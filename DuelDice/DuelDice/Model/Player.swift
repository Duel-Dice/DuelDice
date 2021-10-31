//
//  Player.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import Foundation

// MARK: - User

class Player: NSObject {
    var item: [Int]
    
    item.filter({
        
    })
    var instance: UserModel?
    var dices: [DiceModel] = []
    var network = Network()
    var sumOfDiceResult = 0
    
    func createUserInstance() {
        guard let instance:UserModel = DecodeJson().to(rawData: network.myData()) else { assert(false) }
        self.instance = instance
    }

    func createUserInstanceBy(name: String, tag: String) {
        guard let instance:UserModel = DecodeJson().to(rawData: network.someoneData(name: name, tag: tag)) else { assert(false) }
        self.instance = instance
    }

    func createDiceModel() -> DiceModel {
        let dice:DiceModel = DecodeJson().to(rawData: network.diceData())
        return dice
    }

    func addDiceModel() {
        guard (instance != nil) else { assert(false) }
        var amount = 0
        while amount < self.instance?.diceUUIDArray.count ?? 0 {
            let dice = createDiceModel()
            self.dices.append(dice)
            amount += 1
        }
    }

    func requestRollingDices() {
        self.sumOfDiceResult = 0
        let roll: DiceRoll = DecodeJson().to(rawData: network.diceRoll())
        for element in roll.numbers {
#if DEBUG
            print(element)
#endif
            self.sumOfDiceResult += element
        }
    }
}
