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
    
    var numQuestionsOptions = ["5", "10", "20", "All"]
    @State private var chosenQuestionOption = 0
    
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    
    @State private var userAnswer = ""

    var body: some View {
        if playingGame {
            VStack {
                HStack {
                    Text("\(questions[currentQuestion].text)")
                    TextField("", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .fixedSize()
                    Spacer()
                    Button(action: {
                        self.submitAnswer()
                        
                    }) {
                        Text("Submit")
                    }
                    Spacer()
                }
            }
            
        } else {
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
                }
                Button(action: {
                    self.newGame()
                    
                }) {
                    Text("Start Game")
                }
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
        playingGame = true
        if chosenQuestionOption != 3 {
            numQuestions = Int(numQuestionsOptions[chosenQuestionOption]) ?? 0
            self.questions = loadQuestions(numQuestions: numQuestions)
        } else {
            self.questions = loadQuestions(numQuestions: -1)
            numQuestions = questions.count
        }
//        print(upTo)
//        print(questions[0].text)
    }
    
    func submitAnswer() {
        if userAnswer == questions[currentQuestion].result {
            if currentQuestion < numQuestions {
                currentQuestion += 1
            }
        }
        print("User answer is \(userAnswer), answer is \(questions[currentQuestion].result)\n")
//        print(currentQuestion)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
