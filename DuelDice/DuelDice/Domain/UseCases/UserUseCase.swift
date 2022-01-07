//
//  UseCases.swift
//  DuelDice
//
//  Created by su on 2022/01/07.
//

import Foundation
import FirebaseAuth



final class UserUseCase {

    func fetchUser() -> Challenger? {
        do {
            
            guard let user = Auth.auth().currentUser else { return nil }
            
            
            guard let encodedData = UserDefaults.standard.data(forKey: "challenger") else { return nil }
            let buddy = try JSONDecoder().decode(Challenger.self, from: encodedData)
            return buddy
        } catch {
            return nil
        }
    }
    
}
