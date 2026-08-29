//
//  EditDestionationView.swift
//  ITour
//
//  Created by ZML-MAC-RahulM-01 on 27/04/26.
//

import SwiftUI
import SwiftData

struct EditDestionationView: View {
    @Binding var destination: Destination
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destionation", details: "Example destination details with go here and will exapnd as you add more details")
        return EditDestionationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
