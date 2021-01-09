//
//  ResultsView.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var dices: Dices
    
    var body: some View {
        NavigationView{
            List{
                ForEach(dices.dices.reversed()){ index in
                    VStack{
                        Text("\(index.number)")
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Past Rolls")
        }
    }
    
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
