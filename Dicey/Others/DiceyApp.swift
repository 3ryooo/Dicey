//
//  DiceyApp.swift
//  Dicey
//

import SwiftUI
import SwiftData

@main
struct DiceyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Dice.self)
        }
    }
}
