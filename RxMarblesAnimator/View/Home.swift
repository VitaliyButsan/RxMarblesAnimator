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
    @StateObject private var viewModel = AnimatorViewModel()

    var body: some View {
        TabView {
            ZStack {
                Rectangle().fill(bgGradient).ignoresSafeArea()
                VStack(spacing: 30) {
                    Sequence(marbles: viewModel.inputMarbles, touch: $touch)
                    OperatorView(viewModel: viewModel, touch: $touch)
                    Sequence(marbles: viewModel.outputMarbles, touch: $touch)
                }
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

struct Sequence: View {
    let marbles: [MarbleModel]
    @Binding var touch: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Arrow().stroke(Color.black, lineWidth: 3)
            SignalView(touch: $touch)
            ForEach(marbles, id: \.xOffset) { Marble(marble: $0, touch: $touch) }
            CompletionView()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width, height: 40)
    }
}

struct OperatorView: View {
    @StateObject var viewModel: AnimatorViewModel
    @State private var durationValue = 0.5
    @Binding var touch: Bool
    
    var body: some View {
        Button {
            withAnimation(Animation.easeIn(duration: durationValue)) {
                self.touch.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + durationValue) {
                self.touch.toggle()
            }
        } label: {
            Text(viewModel.operatorType.description)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white))
        }
        .font(.title2)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

struct Marble: View {
    private let diameter: CGFloat = 30.0
    let marble: MarbleModel
    @Binding var touch: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .opacity(touch ? 0 : 1)
                .frame(width: touch ? diameter * 2 : diameter, height: touch ? diameter * 2 : diameter)
            Circle()
                .fill(Color.green)
                .frame(width: diameter, height: diameter)
            Text("\(marble.title)")
        }
        .frame(width: diameter * 2, height: diameter * 2)
        .offset(x: marble.xOffset)
    }
}

struct CompletionView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 3, height: 20)
            .offset(x: UIScreen.main.bounds.width - 60)
    }
}

struct SignalView: View {
    @Binding var touch: Bool
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        SignalShape()
            .fill(Color.purple)
            .offset(x: touch ? screenWidth : -40)
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
