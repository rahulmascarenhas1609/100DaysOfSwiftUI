//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by ZML-MAC-RahulM-01 on 07/08/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            GridStack(rows: 4, columns: 4) { row, col in
                        Text("R\(row) C\(col)")
                    }
            
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
            }
            
            
            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(.red)
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.green)
            .padding()
            .background(.yellow)
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)

            VStack(spacing: 10) {
                CapsuleText(text: "First")
                    .foregroundStyle(.white)
                CapsuleText(text: "Second")
                    .foregroundStyle(.yellow)
                Text("Custom modifier")
                    .modifier(Title())
            }
            

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}




#Preview {
    ContentView()
}
