//
//  RollHistoryView.swift
//  Dicey
//

import SwiftUI

struct RollHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var sets: DiceSet
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(sets.dicevalues) { sets in
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
                    print(sets.dicevalues)
                }
                Button("完了") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    RollHistoryView(sets: DiceSet())
}
