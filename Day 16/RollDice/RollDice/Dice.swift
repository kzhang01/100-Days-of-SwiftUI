//
//  Dice.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

class Dice: Identifiable, Codable{
    var id = UUID()
    var number = 0
}

class Dices: ObservableObject{
    @Published var dices: [Dice]
    static let diceKey = "Dice"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: Self.diceKey){
            if let decoded = try? JSONDecoder().decode([Dice].self, from: data) {
                self.dices = decoded
                return
            }
        }
        
        self.dices = []
    }
    
    func add(_ dice: Dice){
        dices.append(dice)
        if let encoded = try? JSONEncoder().encode(dices){
            UserDefaults.standard.set(encoded, forKey: Self.diceKey)
        }
    }
}
