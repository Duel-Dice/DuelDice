//
//  Forms.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/07.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nickName = "nickname"
        case diceAmount = "dice_count"
        case highestScore = "highest_score"
        case winCount = "win_count"
        case loseCount = "lose_count"
    }
    
    var userId: String?
    var nickName: String?
    var diceAmount: Int?
    var highestScore: Int?
    var winCount: Int?
    var loseCount: Int?
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

struct Login: Codable {
    let firebase_uid: String
}

struct Register: Codable {
    let firebase_uid: String
    let nickname: String
}


struct Nickname: Codable {
    let nickname: String
}


