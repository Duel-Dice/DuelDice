//
//  ViewController.swift
//  DuelDice
//
//  Created by su on 2021/10/25.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SignViewController: UIViewController {
    let data: Int = 42
    @IBOutlet var testLabel: UILabel!
    static let showClientSegueIdentifier = "ShowClientDetailSegue"
    
    @IBOutlet weak var signInButton: GIDSignInButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if(GIDSignIn.sharedInstance.hasPreviousSignIn()) {
//            GIDSignIn.sharedInstance.restorePreviousSignIn()
//            performSegue(withIdentifier: Self.showClientSegueIdentifier, sender: self)
//          } else {
//            print("need to login")
//         }
        
        if Auth.auth().currentUser != nil {
            print("User is signed in.")
            performSegue(withIdentifier: Self.showClientSegueIdentifier, sender: self)
        } else {
            print("No user is signed in.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showClientSegueIdentifier,
           let destination = segue.destination as? ClientViewController {
            destination.configure(with: data) {
                print("\n\nview is changed!\n\n")
            }
        }
    }

    @IBAction func signInButtonTabbed(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if let error = error {
                print("GIDSignIn error: \(error)")
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Firebase sign in error: \(error)")
                    return
                } else {
                    performSegue(withIdentifier: Self.showClientSegueIdentifier, sender: sender)
                    print("User is signed with Firebase&Google")
                }
            }
        }
    }
    
    
    
}

extension SignViewController {
    func firebaseAnonymousSignIn() {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                return
            }
            let isAnonymous = user.isAnonymous
            let uid = user.uid
            
            print(uid)
            print(isAnonymous)
        }
    }
}
