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

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineWidth: CGFloat = 5
    @State private var colorCycle = 0.0
    
    var body: some View {
        Arrow()
            .stroke(Color.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: 150, height: 200)
            .onTapGesture {
                withAnimation {
                    self.lineWidth = self.lineWidth == 5 ? 10 : 5
                }
            }

        ColorCyclingRectangle(amount: self.colorCycle)
            .frame(width: 300, height: 300)

        Slider(value: $colorCycle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
