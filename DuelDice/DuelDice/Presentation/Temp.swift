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
import FBSDKLoginKit
import Alamofire

class Temp: UIViewController {
    static let showClientSegueIdentifier = "ShowClientDetailSegue"
    
//    @IBOutlet var googleSignInButton: GIDSignInButton!
//    @IBOutlet var emailSignInButton: UIButton!
    @IBOutlet var signInStackView: UIStackView!
    var uid: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let googleSignInButton = GIDSignInButton()
        let emailSignInButton = UIButton()
        let facebookSignInButton = FBLoginButton()
        let anonymousSignInButton = UIButton()
        
        signInStackView.addArrangedSubview(googleSignInButton)
        signInStackView.addArrangedSubview(emailSignInButton)
        signInStackView.addArrangedSubview(facebookSignInButton)
        signInStackView.addArrangedSubview(anonymousSignInButton)
        
        signInStackView.spacing = 10
        
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.addTarget(self, action: #selector(googleSignInButtonTabbed), for: .touchUpInside)
        googleSignInButton.heightAnchor.constraint(equalToConstant: 425).isActive = true
        googleSignInButton.widthAnchor.constraint(equalToConstant: 225).isActive = true
        
        emailSignInButton.translatesAutoresizingMaskIntoConstraints = false
        emailSignInButton.addTarget(self, action: #selector(emailSignInButtonTabbed), for: .touchUpInside)
        emailSignInButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        emailSignInButton.widthAnchor.constraint(equalToConstant: 225).isActive = true
        
        emailSignInButton.backgroundColor = .orange
        emailSignInButton.layer.cornerRadius = 2
        emailSignInButton.setTitle("Sign In with Email", for: .normal)
        emailSignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        emailSignInButton.setTitleColor(.white, for: .normal)
        
        facebookSignInButton.delegate = self
//        facebookSignInButton.center = signInStackView.center
        facebookSignInButton.translatesAutoresizingMaskIntoConstraints = false
        facebookSignInButton.heightAnchor.constraint(equalToConstant: 425).isActive = true
        facebookSignInButton.widthAnchor.constraint(equalToConstant: 225).isActive = true
        //        facebookSignInButton.topAnchor.constraint(equalTo: emailSignInButton.bottomAnchor, constant: 0).isActive = true
        //        facebookSignInButton.bottomAnchor.constraint(equalTo: signInStackView.bottomAnchor, constant: 0).isActive = true
        
        anonymousSignInButton.translatesAutoresizingMaskIntoConstraints = false
        anonymousSignInButton.addTarget(self, action: #selector(anonymousSignInButtonTabbed), for: .touchUpInside)
        anonymousSignInButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        anonymousSignInButton.widthAnchor.constraint(equalToConstant: 225).isActive = true
        
        anonymousSignInButton.backgroundColor = .black
        anonymousSignInButton.layer.cornerRadius = 2
        anonymousSignInButton.setTitle("Sign In with Anonymous", for: .normal)
        anonymousSignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        anonymousSignInButton.setTitleColor(.white, for: .normal)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        hasPreviousSignIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showClientSegueIdentifier,
           let destination = segue.destination as? ClientViewController,
            let uid = uid {
            destination.configure(with: uid) {
                print("\n\nview is changed!\n\n")
            }
        }
    }
    
    private func isSignInSuccess(with uid: String?) {
        self.uid = uid
        performSegue(withIdentifier: Self.showClientSegueIdentifier, sender: self)
    }

    private func hasPreviousSignIn() {
        if let user = Auth.auth().currentUser {
            print("User is signed in. [\(user.uid)]")
            performSegue(withIdentifier: Self.showClientSegueIdentifier, sender: self)
        } else {
            print("No user is signed in.")
        }
    }
    
    private func firebaseSignIn(with credential: AuthCredential, _ sender: Any)  {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase(with Google) sign in error: \(error)")
                return
            } else {
                self.isSignInSuccess(with: authResult?.user.uid)
                print("User is signed with Firebase&Google")
            }
        }
    }
    
    private func firebaseCreateUser(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let Autherror = error as NSError
                switch AuthErrorCode(rawValue: Autherror.code) {
                case .operationNotAllowed:
                    // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    print("Error: operationNotAllowed")
                case .emailAlreadyInUse:
                    // Error: The email address is already in use by another account.
                    print("Error: emailAlreadyInUse")
                case .invalidEmail:
                    // Error: The email address is badly formatted.
                    print("Error: invalidEmail")
                case .weakPassword:
                    // Error: The password must be 6 characters long or more.
                    print("Error: weakPassword")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                let newUserInfo = Auth.auth().currentUser
                //                let email = newUserInfo?.email
                print("User signs up successfully \(newUserInfo!.uid)")
            }
        }
    }
}

extension Temp: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider
          .credential(withAccessToken: AccessToken.current!.tokenString)
        
        firebaseSignIn(with: credential, self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
}

// Button Actions
// Email, Google, Phone, Facebook, Github
extension Temp {
//    @IBAction func googleSignInButtonTabbed(_ sender: Any) {

    @objc func googleSignInButtonTabbed(_ sender: UIButton!)  {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print("Google Sign-In error: \(error)")
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
            
            firebaseSignIn(with: credential, sender!)
        }
    }
//    @IBAction func emailSignInButtonTabbed(_ sender: Any) {
    @objc func emailSignInButtonTabbed(_ sender: UIButton!) {
        let email = "wkdlfflxh@naver.com"
        let password = "asdf1234"

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let Autherror = error as NSError
                
                switch AuthErrorCode(rawValue: Autherror.code) {
                case .operationNotAllowed:
                    // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    print("Error: operationNotAllowd")
                case .userDisabled:
                    // Error: The user account has been disabled by an administrator.
                    print("Error: userDisabled")
                case .wrongPassword:
                    // Error: The password is invalid or the user does not have a password.
                    print("Error: wrong password")
                case .invalidEmail:
                    // Error: Indicates the email address is malformed.
                    print("Error: invalid Email")
                case .userNotFound:
                    // Error: User Not Found.
                    self?.firebaseCreateUser(withEmail: email, password: password)
                    print("Error: user Not Found & create User")
                default:
                    // Error: Default Error.
                    print("Error: \(error.localizedDescription), \(Autherror.code)")
                }
            } else {
                guard let strongSelf = self else { return }
                strongSelf.isSignInSuccess(with: authResult?.user.uid)
                print("User is signed with Firebase&Email ")
            }
        }
    }
    @objc func anonymousSignInButtonTabbed(_ sender: Any) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                return
            }
            self.isSignInSuccess(with: user.uid)
        }
    }
}

// Anonymous Signin
//
//extension Temp {
//    func firebaseAnonymousSignIn() {
//        Auth.auth().signInAnonymously { authResult, error in
//            guard let user = authResult?.user else {
//                return
//            }
//            let isAnonymous = user.isAnonymous
//            let uid = user.uid
//
//            print(uid)
//            print(isAnonymous)
//        }
//    }
//}
