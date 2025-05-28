//
//  Dice.swift
//  Dicey
//

import Foundation
import SwiftData

@Model
class Dice: Identifiable {
    var id = UUID()
    var diceValue1: Int
    var diceValue2: Int
    var diceValue3: Int
    var sumOfDice: Int
    var createdAt: Date
    
    init(diceValue1: Int, diceValue2: Int, diceValue3: Int, sumOfDice: Int, createdAt: Date) {
        self.diceValue1 = diceValue1
        self.diceValue2 = diceValue2
        self.diceValue3 = diceValue3
        self.sumOfDice = sumOfDice
        self.createdAt = createdAt
    }
    
    
}
