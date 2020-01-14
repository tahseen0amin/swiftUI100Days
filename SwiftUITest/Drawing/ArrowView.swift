//
//  ArrowView.swift
//  SwiftUITest
//
//  Created by Tasin Zarkoob on 12/01/2020.
//  Copyright © 2020 Taazuh. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY/2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY/2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: rect.midX/2, y: rect.midY/2))
        path.addLine(to: CGPoint(x: rect.midX/2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.75, y: rect.midY/2))
        
        return path
    }
}

struct Arrow2: Shape {
    let arrowHeadWidth: CGFloat = 0.40
    let arrowHeadMin: CGFloat = 0.25
    let arrowHeadMax: CGFloat = 0.75
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * arrowHeadWidth))
        path.addLine(to: CGPoint(x: rect.maxX * arrowHeadMin, y: rect.maxY * arrowHeadWidth))
        path.addLine(to: CGPoint(x: rect.maxX * arrowHeadMin, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * arrowHeadMax, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * arrowHeadMax, y: rect.maxY * arrowHeadWidth))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * arrowHeadWidth))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ArrowView: View {
    @State private var lineWidth: CGFloat = 5
    
    var body: some View {
        VStack {
            withAnimation {
                Arrow2()
                    .stroke(Color.black, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 300)
            }
            
            HStack {
                Text("Line Width: \(lineWidth, specifier: "%g")")
                Slider(value: $lineWidth, in: 5...40, step: 3)
                    .padding()
            }.padding(.horizontal)
            
        }
       
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
