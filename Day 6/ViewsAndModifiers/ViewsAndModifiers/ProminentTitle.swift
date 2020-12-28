//
//  ProminentTitle.swift
//  ViewsAndModifiers
//
//  Created by Karina Zhang on 12/28/20.
//

import SwiftUI
struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
            .background(Color.white)
    }
}

extension View {
    func prominentTitle() -> some View {
        self.modifier(ProminentTitle())
    }
}

