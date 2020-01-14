//
//  ColorCyclingRectangle.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 12/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 140
    var startPoint: UnitPoint = .top
    var endPoint: UnitPoint = .bottom
    
    var body: some View {
        ZStack {
            ForEach(0..<steps){ value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: self.startPoint, endPoint: self.endPoint), lineWidth: 2)
            }
        }.drawingGroup()
    }
    
    private func color(for value: Int, brightness: Double) -> Color{
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    
    @State private var colorCycle = 0.0
    
    var body: some View {
       VStack {
        ColorCyclingRectangle(amount: self.colorCycle, steps: 150, startPoint: .topLeading, endPoint: .topTrailing)
               .frame(width: 300, height: 300)

           Slider(value: $colorCycle)
       }.padding()
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
