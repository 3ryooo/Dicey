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
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.purple.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    settingsContent
                    diceDisplayContent
                    sumDisplayContent
                    rollButtonContent
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Dicey")
            .toolbar {
                Button {
                    showingSheet = true
                } label: {
                    Label("履歴", systemImage: "list.bullet.rectangle.portrait")
                }
            }
            .sheet(isPresented: $showingSheet) {
                RollHistoryView()
            }
        }
    }
    
    private var settingsContent: some View {
        GroupBox {
            HStack {
                Text("サイコロの面")
                    .font(.headline)
                    .accessibilityLabel("The dice side")
                Spacer()
                Button {
                    decrementSides()
                } label: {
                    Image(systemName: "minus.circle.fill")
                }
                .disabled(numberOfSides <= 1)

                Text("\(numberOfSides)面")
                    .font(.title3.bold())
                    .frame(minWidth: 70, alignment: .center)
                    .accessibilityLabel("The current dice face is set to \(numberOfSides)")

                Button {
                    incrementSides()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(numberOfSides >= 100)
            }
            Divider()
            HStack {
                Text("サイコロの数")
                    .font(.headline)
                    .accessibilityLabel("Number of dice")
                Spacer()
                Picker("サイコロの数", selection: $numberOfDice) {
                    ForEach(1..<4, id: \.self) {
                        Text("\($0)個")
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: numberOfDice) {
                    resetDiceValues()
                }
            }
        }
        .padding(.horizontal)
        .backgroundStyle(.thinMaterial)
    }

    private var diceDisplayContent: some View {
        Section {
            HStack {
                Spacer()
                ForEach(0..<currentRollValues.count, id: \.self) { index in
                    VStack {
                        Text(String(currentRollValues[index]))
                            .font(.system(size: 40, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .accessibilityLabel("No.\(index + 1) Dice is \(currentRollValues[index])")
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
                            Text("0")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .accessibilityHidden(true)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        if index < numberOfDice - 1 {
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
        }
    }

    private var sumDisplayContent: some View {
        Section {
            Text("合計値")
                .font(.title2.bold())
                .accessibilityHidden(true)
            Text(String(sumOfDice))
                .font(.largeTitle.bold())
                .foregroundColor(.primary)
                .accessibilityLabel("The total is \(sumOfDice)")
        }
    }

    private var rollButtonContent: some View {
        Section {
            Button {
                diceEffect()
            } label: {
                Label("振る！", systemImage: "dice.fill")
                    .font(.title.bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            }
            .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: sumOfDice)
            .accessibilityLabel("Roll the dice")
        }
        .padding(.horizontal)
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
    
    func incrementSides() {
        if numberOfSides < 100 {
            numberOfSides += 1
        }
    }

    func decrementSides() {
        if numberOfSides > 1 {
            numberOfSides -= 1
        }
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
