//
//  WaitingRoomViewController.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Alamofire

class ClientViewController: UIViewController {
    typealias ViewChangeAction = () -> Void
    
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var delUserButton: UIButton!
    @IBOutlet var titleLabel: UILabel!

    private var data: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        titleLabel.text = data.description
    }
    
    func configure(with data: String, changeAction: @escaping ViewChangeAction) {
        print(data)
        self.data = data
    }
    @IBAction func signOutButtonTabbed(_ sender: Any) {
//        print(GIDSignIn.sharedInstance.currentUser != nil)
//        GIDSignIn.sharedInstance.disconnect { error in
//            guard error == nil else { return }
//        }
//        print(GIDSignIn.sharedInstance.currentUser != nil)
//        GIDSignIn.sharedInstance.signOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
      
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func delUserButtonTabbed(_ sender: Any) {
//        let user = Auth.auth().currentUser
//
//        user?.delete { error in
//          if let error = error {
//            print("User delete error: \(error)")
//          } else {
//            print("User Account Deleted!")
//          }
//        }
        func post(with idToken: String) {
            let apiURL = "https://skyrich3.synology.me:7780/dueldice/dev/api/auth/login"
            let param: Parameters = [
                "firebase_jwt": idToken
                ]
            AF.request(apiURL, method: .post, parameters: param, encoding: URLEncoding.httpBody) .validate(statusCode: 200..<300).responseString() { response in
                switch response.result {
                case .success:
                    print("success")

                case .failure(let error):
                    print(error)
                    return
                }
            }
        }

        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            guard let idToken = idToken else { return }
            if let error = error {
              // Handle error
              return;
            }
            post(with: idToken)
        }

    }
    
}
