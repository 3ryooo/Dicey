//
//  ContentView.swift
//  Dicey
//

import SwiftUI

struct ContentView: View {
    
    @State private var diceValue = Int.random(in: 1...6)
    
    @State private var sets = DiceSet()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("履歴") {
                    RollHistoryView(sets: sets)
                }
                Text(String(diceValue))
                Button("Roll") {
                    rollDice()
                }
            }
            .toolbar {
                Button("debug") {
                    print(sets.dicevalues)
                }
            }
        }
        
        
    }
    
    func rollDice() {
        sets.dicevalues.append(diceValue)
        diceValue = Int.random(in: 1...6)
    }
    
}

#Preview {
    ContentView()
}
