//
//  ContentView.swift
//  Edutainment
//
//  Created by Karina Zhang on 12/30/20.
//

import SwiftUI

struct Question {
    var text: String
    var result: String
}

struct ContentView: View {
    @State private var upTo = 1
    @State private var numQuestions = 0
    @State private var playingGame = false
    @State private var showingResults = false
    
    var numQuestionsOptions = ["5", "10", "20", "All"]
    @State private var chosenQuestionOption = 0
    
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    
    @State private var userAnswer = ""
    @State private var correct = 0
    @State private var beenSubmitted = false

    var body: some View {
        if showingResults {
            ZStack {
                Image("confetti")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    Text("Congrats! You got \(correct) out of \(numQuestions) correct")
                    Button(action: {
                        playingGame = false
                        showingResults = false
                        
                    }) {
                        Text("Play again to improve your score?")
                    }
                }
            }
        } else if playingGame {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(questions[currentQuestion].text)")
                            .font(.largeTitle)
                        TextField("", text: $userAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .fixedSize()
                            .keyboardType(.numberPad)
                        Spacer()
                        
                    }
                    Spacer()
                    Button(action: {
                        self.submitAnswer()
                    }) {
                        Text("Submit")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                    Spacer()
                }
            }
        } else {
            NavigationView {
                Form {
                    VStack {
                        Section(header: Text("Choose your times table").font(.headline)) {
                            Stepper(value: $upTo, in: 1...12, step: 1) {
                                Text("\(upTo)")
                            }
                        }
                        Section(header: Text("How many questions?").font(.headline)) {
                            Picker(selection: $chosenQuestionOption, label: Text("")) {
                                ForEach(0 ..< numQuestionsOptions.count) {
                                   Text(self.numQuestionsOptions[$0])
                                }
                             }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Button(action: {
                            self.newGame()
                            
                        }) {
                            Text("Start Game")
                        }
                    }
                }
                .navigationTitle("Multiplication Game")
            }
        }
        
    }
    
    func loadQuestions(numQuestions: Int) -> [Question] {
        var questions = [Question]()
        for i in Range(1...upTo) {
            for j in Range(1...upTo) {
                let result = String(i * j)
                questions.append(Question(text: "\(i) x \(j) =", result: result))
            }
        }
        questions.shuffle()
        if numQuestions < 0 || numQuestions > questions.count{
            return questions
        }
        
        return Array(questions[0..<numQuestions])
    }
    
    func newGame() {
        correct = 0
        currentQuestion = 0
        playingGame = true
        if chosenQuestionOption != 3 {
            numQuestions = Int(numQuestionsOptions[chosenQuestionOption]) ?? 0
            self.questions = loadQuestions(numQuestions: numQuestions)
        } else {
            self.questions = loadQuestions(numQuestions: -1)
        }
        if (chosenQuestionOption == 3 || numQuestions > questions.count) {
            self.numQuestions = questions.count
        }
    }
    
    func submitAnswer() {
        self.beenSubmitted = true
        if userAnswer == questions[currentQuestion].result {
            correct += 1
        }
        print("User answer is \(userAnswer), answer is \(questions[currentQuestion].result)\n")
        print("current q is \(currentQuestion), numQUestions - 1 is \(questions.count - 1)\n")

        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            showingResults = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
