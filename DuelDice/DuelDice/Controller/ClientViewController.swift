//
//  WaitingRoomViewController.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ClientViewController: UIViewController {
    typealias ViewChangeAction = () -> Void
    
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var delUserButton: UIButton!
    @IBOutlet var titleLabel: UILabel!

    private var data: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = data.description
    }
    
    func configure(with data: Int, changeAction: @escaping ViewChangeAction) {
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
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            print("User delete error: \(error)")
          } else {
            print("User Account Deleted!")
          }
        }
    }
    
}
