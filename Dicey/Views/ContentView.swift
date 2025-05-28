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
    @State private var currentRollValues: [Int] = []
    @State private var sumOfDice = 0
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Section {
                        HStack {
                            Text("サイコロの面")
                            Spacer()
                            Picker("サイコロの面", selection: $numberOfSides) {
                                ForEach(1..<101, id: \.self) {
                                    Text("\($0)面")
                                }
                            }
                        }
                        HStack {
                            Text("サイコロの数")
                            Spacer()
                            Picker("サイコロの数", selection: $numberOfDice) {
                                ForEach(1..<4, id: \.self) {
                                    Text("\($0)個")
                                }
                            }
                            .onChange(of: numberOfDice) {
                                resetDiceValues()
                            }
                        }
                    }
                    .padding()
                    .font(.title)
                    .bold()
                    Section {
                        HStack {
                            Spacer()
                            ForEach(0..<currentRollValues.count, id: \.self) { index in
                                VStack {
                                    Text("No.\(index + 1)")
                                    Text(String(currentRollValues[index]))
                                }
                                if index < currentRollValues.count - 1 {
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        if currentRollValues.isEmpty && numberOfDice > 0 {
                            HStack {
                                Spacer()
                                ForEach(0..<numberOfDice, id: \.self) { index in
                                    VStack {
                                        Text("No.\(index + 1)")
                                        Text("0")
                                    }
                                    if index < numberOfDice - 1 {
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .font(.title)
                    .bold()
                    Section {
                        Text("合計値")
                        Text(String(sumOfDice))
                    }
                    .padding()
                    .font(.title)
                    .bold()
                    Section {
                        Button("振る！") {
                            diceEffect()
                        }
                        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: sumOfDice)
                        .padding()
                        .accentColor(Color.white)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 26))
                        .font(.title)
                        .bold()
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
            
        }
        
        
        
    }
    
    func rollDice() {
        currentRollValues = []
        for _ in 0..<numberOfDice {
            currentRollValues.append(Int.random(in: 1...numberOfSides))
        }
        sumOfDice = currentRollValues.reduce(0, +)
        
        let newItem = Dice(rolledValues: currentRollValues, sumOfDice: sumOfDice, createdAt: Date())
        modelContext.insert(newItem)
    }
    
    func resetDiceValues() {
        sumOfDice = 0
        currentRollValues = Array(repeating: 0, count: numberOfDice)
    }
    
    func resetDiceValues(oldValue: Int, newValue: Int) {
        resetDiceValues()
    }
    
    func diceEffect() {
        var timer: Timer!
        var counter = 0
        
        currentRollValues = Array(repeating: 0, count: numberOfDice)
        sumOfDice = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (_) in
            if counter == 10 {
                timer.invalidate()
                rollDice()
            } else {
                for i in 0..<numberOfDice {
                    if currentRollValues.count == numberOfDice {
                         currentRollValues[i] = Int.random(in: 1...numberOfSides)
                    }
                }
            }
            counter += 1
        }
    }
    
}

#Preview {
    ContentView()
}
