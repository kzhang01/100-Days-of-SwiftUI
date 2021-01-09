//
//  ResultsView.swift
//  RollDice
//
//  Created by Karina Zhang on 1/8/21.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var dices: Dices
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return "\(formatter.string(from: date))"
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(dices.dices.reversed()){ index in
                    HStack {
                        Text("🎲 \(index.number)")
                            .font(.headline)
                        Spacer()
                        Text(formatDate(date: index.date))
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
