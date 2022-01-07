//
//  Network.swift
//  DuelDice
//
//  Created by su on 2022/01/06.
//

import Foundation
import Alamofire

struct UserService: APIServiceType {
    
    static func fetchUserInformation (completion: @escaping (String) -> ()) {
        let url = self.url("users")
        
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
    
    static func fetchSpecificUserInformation (completion: @escaping (String) -> ()) {
        let userid = "a4895a84-072b-4e87-82be-f47e16c214a2"
        let url = self.url("users/\(userid)")
        
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
    
    static func createUserAccount (with nickname:String, completion: @escaping (String) -> ()) {
        let url = self.url("users/register")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }

            let parameters: Parameters = [
                "firebase_jwt" : "test_firebase_jwt",
                "nickname" : "\(nickname)"
            ]
            
            AF.request(url,method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
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

    static func updateUserNickname (with nickname:String, completion: @escaping (String) -> ()) {
        let url = self.url("users/register")
        
        self.validate { (idToken) in
            guard let idToken = idToken else {
                return
            }

            let headers: HTTPHeaders = [
                "firebase_jwt" : "Bearer test_firebase_jwt"
            ]
            let parameters: Parameters = [
                "nickname" : "\(nickname)"
            ]
            
            AF.request(url,method: .put, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
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
