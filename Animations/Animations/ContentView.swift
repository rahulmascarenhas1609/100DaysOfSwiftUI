//
//  ContentView.swift
//  Animations
//
//  Created by ZML-MAC-RahulM-01 on 27/08/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    
    let letters = Array("Hello SwiftUI")
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
        
        
        /*
         /// Showing and hiding iews with transitions
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .transition(.pivot)
                
            }
        }
        */
         
        /*
        /// Animated gesture with a delay and animation returning back to origin
        HStack(spacing: 0) {
            ForEach(0..<letters.count,id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue: .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragAmount = $0.translation })
                .onEnded({ _ in
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
        */
        
        /*
        /// Animating gestures
        
        LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ dragAmount = $0.translation })
//                    .onEnded({ _ in
//                        dragAmount = .zero
//                    })
                    .onEnded({_ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    })
            )
            .animation(.bouncy, value: dragAmount)
        
         */
        
        /*
         Controlling the animation stack
        Button("tap me") {
            enabled.toggle()
        }
        .padding(40)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1,bounce: 0.6), value: enabled)
        */
         
        /*
         /// Adds an animation spring to the transtion
         .clipShape(.rect(cornerRadius:  enabled ? 60 : 0))
         .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
         */
        
        
        /*
        Button("Tap me") {
            withAnimation(.spring(duration: 1,bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0,y: 1,z: 0))
        */
        
        /*
        print(animationAmount)
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(3,autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            
        }
        
        */
        
        /*
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(.circle)
//        .scaleEffect(animationAmount)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
//        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false),value: animationAmount)
//        .animation(.easeOut(duration: 1).repeatCount(3,autoreverses: true), value: animationAmount)
//        .animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
//        .animation(.easeInOut(duration: 2), value: animationAmount)
//        .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
         */
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

#Preview {
    ContentView()
}
