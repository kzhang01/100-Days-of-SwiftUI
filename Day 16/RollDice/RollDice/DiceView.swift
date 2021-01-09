//
//  DiceView.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

struct DiceView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var dices: Dices
    @State private var numSides = 6
    
    @State private var diceOptions = [4, 6, 8, 10, 12, 20, 100]
    
    @State var random = 1
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Choose what sided dice you want to roll:")
                HStack(spacing: 20) {
                    Spacer()
                    ForEach(0..<3) { number in
                        Button(action: {
                            numSides = self.diceOptions[number]
                        }) {
                            DiceOption(numSides: self.diceOptions[number])
                                
                        }
                    }
                    Spacer()
                }
                
                HStack(spacing: 15) {
                    Spacer()
                    ForEach(3..<diceOptions.count) { number in
                        Button(action: {
                            numSides = self.diceOptions[number]
                        }) {
                            DiceOption(numSides: self.diceOptions[number])
                                
                        }
                    }
                    Spacer()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    Text("\(random)")
                        .font(.title)
                        .padding()
                }
                
                VStack {
                    Button("Roll \(numSides)-sided dice"){
                        random = Int.random(in: 1 ... numSides)
                        
                        let newDice = Dice()
                        newDice.number = random
                        self.dices.add(newDice)
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Capsule())
                }
                Spacer()
            }
        }
            
        .navigationBarTitle("Roll a Dice")
        
    }
}
struct DiceOption: View {
    var numSides: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7.0)
                .fill(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .frame(width: 50, height: 50)
                .padding()
            
            Text("\(numSides)")
                .padding()
                .foregroundColor(.white)
        }
        
    }
}
struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
