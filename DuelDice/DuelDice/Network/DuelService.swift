//
//  DuelService.swift
//  DuelDice
//
//  Created by su on 2022/01/06.
//

import Foundation
import Alamofire

struct DuelService: APIServiceType {
    
    static func fetchDuelInformation (completion: @escaping (String) -> ()) {
        let url = self.url("duels")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }
            let headers: HTTPHeaders = [
                "firebase_jwt" : "Bearer test_firebase_jwt"
            ]
            
            AF.request(url, encoding: URLEncoding.httpBody, headers: headers)
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
    
    
    static func fetchDuelInformation (by duelId: String, completion: @escaping (String) -> ()) {
        let url = self.url("duels/\(duelId)")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }
            let headers: HTTPHeaders = [
                "firebase_jwt" : "Bearer test_firebase_jwt"
            ]
            
            AF.request(url, encoding: URLEncoding.httpBody, headers: headers)
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
    
    static func createDuel (completion: @escaping (String) -> ()) {
        let url = self.url("duels/start")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }
            let headers: HTTPHeaders = [
                "firebase_jwt" : "Bearer test_firebase_jwt"
            ]
            
            AF.request(url, method: .post, encoding: URLEncoding.httpBody, headers: headers)
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
    
    static func updateDuelRoll(of dicecount: String, completion: @escaping (String) -> ()) {
        let url = self.url("duels/roll/\(dicecount)")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }
            let headers: HTTPHeaders = [
                "firebase_jwt" : "Bearer test_firebase_jwt"
            ]
            
            AF.request(url, method: .put, encoding: URLEncoding.httpBody, headers: headers)
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
