//
//  GuessTheFlagView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 15/12/2019.
//  Copyright © 2019 Taazuh. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: .white, radius: 2)
    }

}

struct GuessTheFlagView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var alertMessage = ""
    
    @State private var animationAmount : CGFloat = 1
    @State private var spinDegree: Double = 0.0
    @State private var opacityAmount : Double = 1.0
    
    
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
                        if number == self.correctAnswer {
                            FlagImage(imageName: self.countries[number])
                                .frame(width: 300, height: 100)
                                .modifier(SpinningViewModifier(angle: self.spinDegree))
                        } else {
                            FlagImage(imageName: self.countries[number])
                                .frame(width: 300, height: 100)
                                .modifier(OpacityViewModifier(opacity: self.opacityAmount))
                        }
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
        .onAppear{self.animationAmount = 2 }
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
        withAnimation {
            self.spinDegree += 360
            self.opacityAmount = 0.25
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        spinDegree = 0
        opacityAmount = 1
        self.countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView()
    }
}

struct PulsatingPulseModifier: ViewModifier {
    var animationAmount: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
        .overlay(
            Capsule()
                .stroke(Color.white)
                .scaleEffect(self.animationAmount)
                .opacity(Double(2 - self.animationAmount))
                .animation(
                    Animation.easeOut(duration: 1).repeatForever(autoreverses: false)
                )
        )
    }
}

struct SpinningViewModifier: ViewModifier {
    var angle: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))
    }
}

struct OpacityViewModifier: ViewModifier {
    var opacity: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .animation(.easeInOut)
    }
}
