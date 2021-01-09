//
//  ContentView.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    var dices = Dices()

    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Image(systemName: "dot.square.fill")
                    Text("Roll Dice")
            }
            
            ResultsView()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Results")
            }
        }
        .environmentObject(dices)

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
