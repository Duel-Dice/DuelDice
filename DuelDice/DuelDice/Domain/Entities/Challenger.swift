//
//  Challenger.swift
//  DuelDice
//
//  Created by su on 2022/01/07.
//

import Foundation

struct Challenger: Hashable, Codable {
    
    var id: UUID
    var name: String
    var face: String
    var check: Bool?
    
}

extension Challenger: Comparable {
    static func < (lhs: Challenger, rhs: Challenger) -> Bool {
        if lhs.name == rhs.name { return lhs.id.uuidString < rhs.id.uuidString }
        return lhs.name < rhs.name
    }
}
