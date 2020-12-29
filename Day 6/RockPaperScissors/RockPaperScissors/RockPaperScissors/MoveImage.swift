//
//  MoveImage.swift
//  RockPaperScissors
//
//  Created by Karina Zhang on 12/28/20.
//

import SwiftUI

struct MoveImage: View {
    var move: String
    
    var body: some View {
        Image(move)
            .resizable()
            .renderingMode(.original)
            .frame(width: 100, height: 100)
            .aspectRatio(CGSize(width: 60, height: 60), contentMode: .fit)
            .clipShape(Capsule())
            .padding()
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
            
    }
}
