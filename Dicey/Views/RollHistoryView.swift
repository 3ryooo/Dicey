//
//  RollHistoryView.swift
//  Dicey
//

import SwiftUI

struct RollHistoryView: View {
    var sets: DiceSet
    
    var tests = [0, 1, 2, 3]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(sets.dicevalues, id: \.self) {
                        Text(String($0))
                    }
                }
            }
            .toolbar {
                Button("debug") {
                    print(sets.dicevalues)
                }
            }
        }
        
        
    }
}

#Preview {
    RollHistoryView(sets: DiceSet())
}
