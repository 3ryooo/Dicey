//
//  Dice.swift
//  Dicey
//

import Foundation

struct Dice: Identifiable {
    let id = UUID()
    var diceValue1: Int
    var diceValue2: Int
    var diceValue3: Int
    var sumOfDice: Int
}

class DiceSet {
    var dicevalues: [Dice] = []
}
