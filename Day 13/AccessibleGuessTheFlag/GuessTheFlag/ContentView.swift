//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Karina Zhang on 12/21/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",
                     "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var chosenNumber = 0
    @State private var isRight = false
    @State private var isWrong = false
    @State private var fadeOut = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                        
                    }) {
                        FlagImage(country: self.countries[number])

                    }
                    .rotation3DEffect(.degrees(self.isRight && (self.chosenNumber == number) ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.fadeOut && (self.chosenNumber != number) ? 0.25 : 1)
                    .rotation3DEffect(.degrees(self.isWrong && (self.chosenNumber == number) ? 90 : 0), axis: (x: 0.5, y: 0, z: 0))
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        self.chosenNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            isRight = true
            fadeOut = true
        } else {
            scoreTitle = "Wrong! That the flag of \(self.countries[number])"
            isWrong = true
            fadeOut = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showingScore = true
        }
    }

    func askQuestion() {
        isWrong = false
        isRight = false
        fadeOut = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
