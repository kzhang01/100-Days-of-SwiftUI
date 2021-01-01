//
//  ContentView.swift
//  Drawing
//
//  Created by Karina Zhang on 12/31/20.
//

import SwiftUI

struct Arrow: Shape {
    var rectWidth: CGFloat = 30
    var triangleBase: CGFloat = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // rectangle
        path.move(to: CGPoint(x: rect.midX - (rectWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectWidth / 2), y: rect.midY / 2))

        // triangle
        path.addLine(to: CGPoint(x: rect.midX + (triangleBase / 2), y: rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - (triangleBase / 2), y: rect.midY / 2))

        // rectangle
        path.addLine(to: CGPoint(x: rect.midX - (rectWidth / 2), y: rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.midX - (rectWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectWidth / 2), y: rect.maxY))

        return path
    }
}

struct ContentView: View {
    @State private var lineWidth: CGFloat = 5
    
    var body: some View {
        Arrow()
            .stroke(Color.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: 150, height: 200)
            .onTapGesture {
                withAnimation {
                    self.lineWidth = self.lineWidth == 5 ? 10 : 5
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
