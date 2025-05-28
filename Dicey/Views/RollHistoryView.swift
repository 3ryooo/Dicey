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
                        Text(String(sets.sumOfDice))
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
