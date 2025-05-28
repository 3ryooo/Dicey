//
//  RollHistoryView.swift
//  Dicey
//

import SwiftUI
import SwiftData

struct RollHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query private var sets: [Dice]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(sets) { sets in
                        Text(
                            String("1個目：\(sets.diceValue1)\n") +
                            String("2個目：\(sets.diceValue2)\n") +
                            String("3個目：\(sets.diceValue3)\n") +
                            String("合計：\(sets.sumOfDice)")
                        )
                    }
                }
            }
            .toolbar {
                Button("debug") {
                    print(sets)
                }
                Button("完了") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    RollHistoryView()
        .modelContainer(for: Dice.self)
}
