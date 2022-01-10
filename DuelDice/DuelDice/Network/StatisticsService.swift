//
//  StatisticsService.swift
//  DuelDice
//
//  Created by su on 2022/01/06.
//

import Foundation
import Alamofire

struct StatisticsService: APIServiceType {
    static func fetchUserInformation(with dicecount: String, completion: @escaping (String) -> ()) {
        let url = self.url("statistics/users/\(dicecount)")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }
            
            AF.request(url, encoding: URLEncoding.httpBody)
                .validate(statusCode: 200..<300)
                .responseString() { response in
                switch response.result {
                case .success:
                    completion("hello")
                case .failure(let error):
                    completion("nn")
                    print(error)
                    return
                }
            }
        }
    }
}
