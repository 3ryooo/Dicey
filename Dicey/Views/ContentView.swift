//
//  ContentView.swift
//  Dicey
//

import SwiftUI

struct ContentView: View {
    
    @State private var diceValue = Int.random(in: 1...6)
    
    var body: some View {
        VStack {
            Text(String(diceValue))
            Button("Roll") {
                rollDice()
            }
        }
        .padding()
        
    }
    
    func rollDice() {
        diceValue = Int.random(in: 1...6)
    }
    
}

#Preview {
    ContentView()
}
