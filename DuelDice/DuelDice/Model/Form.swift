//
//  Forms.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/07.
//

import Foundation

struct User: Codable {
    var userId: String
    var accessToken: String
    var nickName: String
    var diceAmount: Int
    var highestScore: Int
    var winCount: Int
    var loseCount: Int
}

struct Duel: Codable {
    var duelId: String
    var userId1: String
    var userId2: String
    var dice1: [Int]
    var dice2: [Int]
    var status1: Int
    var status2: Int
    var isDone: Bool
}
