//
//  SwiftUIView.swift
//  OverlayKit
//
//  Created by ZML-MAC-RahulM-01 on 30/06/26.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Dummy List Row View")
            }
            .navigationTitle("Toasts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
