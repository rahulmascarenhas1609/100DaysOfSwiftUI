//
//  ContentView.swift
//  PracticeProject
//
//  Created by ZML-MAC-RahulM-01 on 02/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Count: \(count)")
                .font(.title)
            Button("Increment") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
