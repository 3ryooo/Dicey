//
//  RollHistoryView.swift
//  Dicey
//

import SwiftUI
import SwiftData

struct RollHistoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Dice.createdAt, order: .reverse)]) private var sets: [Dice]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(sets, id: \.id) { diceSet in
                        VStack(alignment: .leading) {
                            Text(String("出目: \(diceSet.rolledValues.map(String.init).joined(separator: ", "))"))
                                .accessibilityLabel("\(diceSet.rolledValues.map(String.init).joined(separator: ", ")) came out on dice")
                            Text("合計: \(diceSet.sumOfDice)")
                                .accessibilityLabel("The total number of dices is \(diceSet.sumOfDice)")
                            Text("日時: \(diceSet.createdAt, format: .dateTime)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .accessibilityLabel("Rolled the dice \(diceSet.createdAt, format: .dateTime)")
                        }
                    }
                    .onDelete(perform: deleteSet)
                }
            }
            .navigationTitle("履歴")
            .toolbar {
                Button("完了") {
                    dismiss()
                }
            }
        }
    }
    
    func deleteSet(at offsets: IndexSet) {
        for offset in offsets {
            let set = sets[offset]
            modelContext.delete(set)
        }
    }
}

#Preview {
    RollHistoryView()
        .modelContainer(for: Dice.self)
}
