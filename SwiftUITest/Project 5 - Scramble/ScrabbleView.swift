//
//  ScrabbleView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 02/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct ScrabbleView: View {
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var usedWords: [String] = []
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(){
                    TextField(" Enter new Word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                        .font(.subheadline)
                    List(usedWords, id: \.self){
                        Image(systemName: "\($0.count).circle")
                        Text($0)
                        .padding()
                        .headlineFont()
                    }
                    Text("YOUR SCORE: \(score)").headlineFont()
                }
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing:
                Button(action: startGame) {
                    Text("Start New Game").foregroundColor(Color.white)
                }
            )
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear(perform: startGame)
    }
    
    private func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard answer.count > 3 else {
            wordError(title: "Word not allowed", message: "Word length is short ")
            return
        }
        
        guard isOrginal() else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't just make up word!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not real", message: "Stop writing gibberish!!")
            return
        }
        
        // insert the word in array
        usedWords.insert(answer, at: 0)
        updateScore(word: answer)
        newWord = ""
    }
    
    private func startGame() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let content = try? String(contentsOf: fileURL) {
                let wordsArray = content.components(separatedBy: "\n")
                rootWord = wordsArray.randomElement() ?? "silkworm"
                usedWords.removeAll()
                score = 0
                return
            }
        }
        
        fatalError("Could not find the start resource")
    }
    
    private func isOrginal() -> Bool {
        if newWord == rootWord {
            return false
        }
        return !usedWords.contains(newWord)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    private func updateScore(word: String){
        score += word.count
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ScrabbleView_Previews: PreviewProvider {
    static var previews: some View {
        ScrabbleView()
    }
}
