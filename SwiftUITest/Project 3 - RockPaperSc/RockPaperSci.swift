//
//  RockPaperSci.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 28/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct RockPaperSci: View {
    var moves = ["rock", "paper", "scissor"]
    @State private var appCurrentChoice: Int = Int.random(in: 0..<2)
    @State private var userScore = 0
    @State private var challenge = Bool.random()
    
    @State private var showResult = false
    @State private var resultMessage: String = ""
    @State private var resultTitle = ""
    
    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack (spacing: 30) {
                    VStack {
                        Text("App's Move")
                        Image(self.moves[appCurrentChoice])
                            .padding()
                        Text("Challenge")
                        Text("\(challenge ? "WIN" : "LOSE")")
                            .padding()
                            .foregroundColor(challenge ? Color.green : Color.red)
                            .headlineFont()
                        Text("YOUR MOVE")
                    }
                    
                    HStack (spacing: 30) {
                        ForEach(0 ..< self.moves.count){ number in
                            Button(action: {
                                self.moveButtonPressed(number)
                            }) {
                                FlagImage(imageName:self.moves[number])
                                    .padding().cornerRadius(20)
                            }
                        }
                    }
                    Spacer()
                    
                    Section(){
                        HStack {
                            Text("User Score")
                            Text("\(userScore)")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .padding()
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Rock Paper Scissor")
        }
        .alert(isPresented: $showResult) { () -> Alert in
            Alert(title: Text(resultTitle),
              message: Text(resultMessage),
              dismissButton: .default(Text("Continue")) {
                self.nextChallenge()
            })
        }
    }
    
    private func moveButtonPressed(_ number: Int) {
        print("PRESSED: \(number)")
        if appCurrentChoice == number {
            // tie but in our case, user failed
            prepareResultMessage(userWin: false)
            return
        }
        let userWon = self.didUserMoveWins(userMove: number)
        if challenge {
            // user was supposed to win
            if userWon {
                prepareResultMessage(userWin: true)
            } else {
                prepareResultMessage(userWin: false)
            }
        } else {
           // user was supposed to lose
            if !userWon {
                prepareResultMessage(userWin: true)
            } else {
                prepareResultMessage(userWin: false)
            }
        }
    }
    
    private func prepareResultMessage(userWin: Bool) {
        if userWin {
            // increase the points
            userScore += 10
            resultTitle = "Correct"
            resultMessage = "That was good.\nKeep going."
        } else {
            // decrease the points
            userScore -= 5
            resultTitle = "Wrong"
            resultMessage = "That was not a correct answer.\nTry Again."
        }
        showResult = true
    }
    
    private func didUserMoveWins(userMove: Int) -> Bool {
        var didWin = false
        switch userMove {
        case 0:
            // user choose rock
            if appCurrentChoice == 1 {
                didWin = false
            } else if appCurrentChoice == 2 {
                didWin = true
            }
            break
        case 1:
            // user choose paper
            if appCurrentChoice == 0 {
                didWin = true
            } else if appCurrentChoice == 2 {
                didWin = false
            }
            break
        case 2:
            // user choose scissor
            if appCurrentChoice == 0 {
                didWin = false
            } else if appCurrentChoice == 1 {
                didWin = true
            }
            break
        default:
            break
        }
        
        return didWin
    }
    
    private func nextChallenge() {
        appCurrentChoice = Int.random(in: 0..<2)
        challenge = Bool.random()
    }
}

struct RockPaperSci_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperSci()
    }
}
