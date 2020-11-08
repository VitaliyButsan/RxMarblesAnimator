//
//  Home.swift
//  RxMarblesAnimator
//
//  Created by vit on 31.10.2020.
//

import SwiftUI

struct Home: View {
    
    private let bgGradient = RadialGradient(gradient: Gradient(colors: [Color.blue, Color.black]), center: .center, startRadius: 0, endRadius: 500)
    
    @State private var touch = false
    @State private var signalOffset: CGFloat = 0.0
    @State private var signalPosition: CGFloat = 0.0
    @State private var durationValue = 1.0

    var body: some View {
        TabView {
            ZStack {
                Rectangle().fill(bgGradient).ignoresSafeArea()
                ZStack {
                    Arrow().stroke(Color.black, lineWidth: 3)
                    CompletionView(xOffset: 140)
                    SignalView(xOffset: $signalOffset)
                    CircleView(xOffset: 80, touch: $touch)
                    CircleView(xOffset: 20, touch: $touch)
                    CircleView(xOffset: -40, touch: $touch)
                    CircleView(xOffset: -100, touch: $touch)
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width, height: 40)
                
                Button {
                    withAnimation(Animation.easeIn(duration: durationValue)) {
                        self.touch.toggle()
                        self.signalOffset = UIScreen.main.bounds.width
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationValue) {
                        self.touch.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + durationValue) {
                        self.signalOffset = 0.0
                    }
                } label: {
                    Text("WaveButton")
                }
                .offset(y: 50)
                .font(.title)
                .foregroundColor(.white)
            }
            .tabItem {
                Image(systemName: "square.grid.3x1.fill.below.line.grid.1x2")
                Text("Animator")
            }
            
            ZStack {
                Rectangle().fill(bgGradient).ignoresSafeArea()
                Text("Empty View")
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("Docs")
            }
        }
        .onAppear {
            UITabBar.appearance().barTintColor = .black
        }
    }
}

struct CircleView: View {
    private let diameter: CGFloat = 20.0
    let xOffset: CGFloat
    @Binding var touch: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: diameter, height: diameter)
            Circle()
                .fill(Color.green)
                .opacity(touch ? 0 : 1)
                .frame(width: touch ? diameter * 2.5 : diameter, height: touch ? diameter * 2.5 : diameter)
        }
        .frame(width: diameter * 2.5, height: diameter * 2.5)
        .offset(x: xOffset)
    }
}

struct CompletionView: View {
    let xOffset: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 3, height: 20)
            .offset(x: xOffset)
    }
}

struct SignalView: View {
    @Binding var xOffset: CGFloat
    
    var body: some View {
        SignalShape()
            .fill(Color.purple)
            .offset(x: xOffset)
            .frame(height: 10)
    }
    
    struct SignalShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.minX + 20, y: rect.midY),
                              control: CGPoint(x: rect.minX + 20, y: rect.minY))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                              control: CGPoint(x: rect.minX + 20, y: rect.maxY))
            return path
        }
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.midY - 5))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - 10, y: rect.midY + 5),
                          control: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
