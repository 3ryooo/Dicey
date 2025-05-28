//
//  ContentView.swift
//  Dicey
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query private var sets: [Dice]
    @State private var numberOfSides = 6
    @State private var numberOfDice = 1
    @State private var diceValue1 = 0
    @State private var diceValue2 = 0
    @State private var diceValue3 = 0
    @State private var sumOfDice = 0
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            Section {
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
            }
            Section {
                HStack {
                    VStack {
                        Text("サイコロ 1")
                        Text(String(diceValue1))
                    }
                    if numberOfDice >= 2 {
                        VStack {
                            Text("サイコロ 2")
                            Text(String(diceValue2))
                        }
                    }
                    if numberOfDice >= 3 {
                        VStack {
                            Text("サイコロ 3")
                            Text(String(diceValue3))
                        }
                    }
                }
            }
            Section {
                Text("合計値")
                Text(String(sumOfDice))
            }
            Section {
                Button("Roll") {
                    rollDice()
                }
            }
            
            .toolbar {
                Button("debug") {
                    print(sets)
                }
                Button("履歴") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                RollHistoryView()
            }
        }
        
        
    }
    
    func rollDice() {
        diceReset()
        diceValue1 = Int.random(in: 1...numberOfSides)
        if numberOfDice >= 2 {
            diceValue2 = Int.random(in: 1...numberOfSides)
        }
        if numberOfDice >= 3 {
            diceValue3 = Int.random(in: 1...numberOfSides)
        }
        sumOfDice = diceValue1 + diceValue2 + diceValue3
        let newItem = Dice(diceValue1: diceValue1, diceValue2: diceValue2, diceValue3: diceValue3, sumOfDice: sumOfDice, createdAt: Date())
        modelContext.insert(newItem)
    }
    
    func diceReset() {
        sumOfDice = 0
        diceValue1 = 0
        diceValue2 = 0
        diceValue3 = 0
    }
    
}

#Preview {
    ContentView()
}
