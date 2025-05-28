//
//  Dice.swift
//  Dicey
//

import Foundation
import SwiftData

@Model
class Dice: Identifiable {
    var id = UUID()
    var rolledValues: [Int]
    var sumOfDice: Int
    var createdAt: Date
    
    init(rolledValues: [Int], sumOfDice: Int, createdAt: Date) {
        self.rolledValues = rolledValues
        self.sumOfDice = sumOfDice
        self.createdAt = createdAt
    }
    
    
}
