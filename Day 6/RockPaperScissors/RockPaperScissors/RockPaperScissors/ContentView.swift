//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Karina Zhang on 12/28/20.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = Int.random(in:0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var timesPlayed = 0

    var moves = ["rock", "paper", "scissors"]
    
    let customCyan = Color(red: 107/255, green: 231/255, blue: 249/255)
    let customPurple = Color(red: 204/255, green: 78/255, blue: 192/255)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [customCyan, customPurple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                
                if timesPlayed <= 10 {
                    VStack (spacing: 15){
                        
                        if shouldWin {
                            Text("Win this game")
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.white)
                                .clipShape(Capsule())
                        } else {
                            Text("Lose this game")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        
                        Text("CPU's move: \(moves[appChoice])")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.black)
                    }
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.moveTapped(number)
                        }) {
                            MoveImage(move: self.moves[number])
                                
                        }
                    }
                } else {
                    Spacer()
                    
                    Image("game-over")
                        .resizable()
                        .frame(width: 300, height: 250)
                        .aspectRatio(CGSize(width: 1168, height: 736), contentMode: .fit)
                    
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Button(action: {
                        self.newGame()
                    }) {
                        Text("Play again?")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .background(customCyan)
                            .clipShape(Capsule())
                    }
                }
  
                Spacer()
            }
        }
    }
    
    func moveTapped(_ number: Int) {
        timesPlayed += 1
        
        if (number - 1 == appChoice) || (number == 0 && appChoice == 2) { //win
            if shouldWin { //player wins when they should win
                score += 1
            } else { //player wins when they shouldn't win
                score -= 1
            }
                
        } else { //lose
            if shouldWin { //player loses when they shouldn't lose
                score -= 1
            } else { //player loses when they they should lose
                score += 1
            }
        }
        
        if timesPlayed <= 10 {
            askQuestion()
        }
    }

    func askQuestion() {
        shouldWin = Bool.random()
        appChoice = Int.random(in: 0...2)
    }
    
    func newGame() {
        timesPlayed = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
