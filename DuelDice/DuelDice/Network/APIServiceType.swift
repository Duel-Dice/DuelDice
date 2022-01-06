//
//  APIType.swift
//  DuelDice
//
//  Created by su on 2022/01/06.
//

import Foundation
import FirebaseAuth

protocol APIServiceType {
    
}

extension APIServiceType {
    static func url(_ path: String) -> String {
        return "https://heyinsa.kr/dueldice/api/" + path
    }
    
    static func validate(completion: @escaping (String?) -> ()) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            guard let idToken = idToken else { return }
            if error != nil {
                completion(nil)
              return;
            }
            completion(idToken)
        }
    }
}
