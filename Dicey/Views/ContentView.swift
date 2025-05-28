//
//  ContentView.swift
//  Dicey
//

import SwiftUI

struct ContentView: View {
    
    @State private var sets = DiceSet()
    
    @State private var numberOfSides = 6
    @State private var numberOfDice = 1
    @State private var diceValue1 = 1
    @State private var diceValue2 = 1
    @State private var diceValue3 = 1
    @State private var sumOfDice = 0
    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("サイコロの面", selection: $numberOfSides) {
                    ForEach(1..<101, id: \.self) {
                        Text("\($0)面")
                    }
                }
                Picker("サイコロの数", selection: $numberOfDice) {
                    ForEach(1..<4, id: \.self) {
                        Text("\($0)個")
                    }
                }
                Text(String(diceValue1))
                Text(String(diceValue2))
                Text(String(diceValue3))
                Text(String(sumOfDice))
                Button("Roll") {
                    rollDice()
                }
            }
            .toolbar {
                Button("debug") {
                    print(sets.dicevalues)
                }
                Button("履歴") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                RollHistoryView(sets: sets)
            }
        }
        
        
    }
    
    func rollDice() {
        sumOfDice = 0
        diceValue1 = Int.random(in: 1...numberOfSides)
        diceValue2 = Int.random(in: 1...numberOfSides)
        diceValue3 = Int.random(in: 1...numberOfSides)
        sumOfDice = diceValue1 + diceValue2 + diceValue3
        sets.dicevalues.append(Dice(diceValue1: diceValue1, diceValue2: diceValue2, diceValue3: diceValue3, sumOfDice: sumOfDice))
    }
    
}

#Preview {
    ContentView()
}
