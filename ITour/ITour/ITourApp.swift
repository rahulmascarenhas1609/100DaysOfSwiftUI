//
//  ITourApp.swift
//  ITour
//
//  Created by ZML-MAC-RahulM-01 on 23/04/26.
//

import SwiftUI
import SwiftData

@main
struct ITourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
