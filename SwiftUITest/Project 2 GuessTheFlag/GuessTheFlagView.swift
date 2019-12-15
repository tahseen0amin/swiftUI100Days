//
//  GuessTheFlagView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 15/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct GuessTheFlagView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var alertMessage = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Guess the Flag of ")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3){ number in
                    Button(action: {
                       // flag was tapped
                        self.buttonWasPressed(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                            .shadow(color: .white, radius: 2)
                    }
                    
                    
                }
                
            }
        }
        .alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text(scoreTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
    
    func buttonWasPressed(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 20
            alertMessage = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That is the flag of \(self.countries[number])"
        }

        showingScore = true
    }
    
    func askQuestion() {
        self.countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView()
    }
}
