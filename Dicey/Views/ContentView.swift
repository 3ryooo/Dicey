//
//  ContentView.swift
//  Dicey
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfSides = 6
    @State private var diceValue = 1
    @State private var sets = DiceSet()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("履歴") {
                    RollHistoryView(sets: sets)
                }
                Picker("aaa", selection: $numberOfSides) {
                    ForEach(0..<101, id: \.self) {
                        Text("\($0)面")
                    }
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
        diceValue = Int.random(in: 1...numberOfSides)
        sets.dicevalues.append(diceValue)
    }
    
}

#Preview {
    ContentView()
}
