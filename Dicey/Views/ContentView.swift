//
//  ContentView.swift
//  Dicey
//

import SwiftUI

struct ContentView: View {
    
    @State private var diceValue = Int.random(in: 1...6)
    var dicevalues: [Int] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(String(diceValue))
                Button("Roll") {
                    rollDice()
                }
            }
            .toolbar {
                Button("debug") {
                    print(dicevalues)
                }
            }
        }
        
        
    }
    
    func rollDice() {
        diceValue = Int.random(in: 1...6)
    }
    
}

#Preview {
    ContentView()
}
