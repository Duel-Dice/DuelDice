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

class SignViewController: UIViewController {
    static let showClientSegueIdentifier = "ShowClientDetailSegue"
    
    // MARK: - Outlet
    
    let googleSignInButton = GIDSignInButton()
    let anonymousSignInButton = UIButton()
    let titleLabel = PaddingLabel()
    let backgroundImageView = UIImageView()
    
    // MARK: - Properties
    
    var uid: String?
    
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // TODO: scenedelegate에서 로그인 유저 로그인 되어 있으면 바로 clientview로, 아니면 signview로 보내기
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showClientSegueIdentifier,
           let destination = segue.destination as? GameWaitingRoom,
            let uid = uid {
            destination.configure(with: uid) {
                print("\n\nview is changed!\n\n")
            }
        }
    }
    
    // MARK: - Private
    
    private func configure() {
        self.configureSignInButton()
        self.configureTitleLabel()
        self.configureImageView()
    }
    
    private func configureSignInButton() {
        self.view.addSubview(self.googleSignInButton)
        self.googleSignInButton.addTarget(self, action: #selector(googleSignInButtonTabbed), for: .touchUpInside)
        self.googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.googleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.googleSignInButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: .signInButtonBottomAnchor),
            self.googleSignInButton.widthAnchor.constraint(equalToConstant: .signInButtonWidth),
            self.googleSignInButton.heightAnchor.constraint(equalToConstant: .signInButtonHeight)
        ])
        
        self.view.addSubview(self.anonymousSignInButton)
        self.anonymousSignInButton.backgroundColor = .black
        self.anonymousSignInButton.layer.cornerRadius = 2
        self.anonymousSignInButton.setTitle("Sign In with Anonymous", for: .normal)
        self.anonymousSignInButton.setTitleColor(.white, for: .normal)
        self.anonymousSignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        self.anonymousSignInButton.translatesAutoresizingMaskIntoConstraints = false
        self.anonymousSignInButton.addTarget(self, action: #selector(anonymousSignInButtonTabbed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            self.anonymousSignInButton.widthAnchor.constraint(equalToConstant: .signInButtonWidth),
            self.anonymousSignInButton.heightAnchor.constraint(equalToConstant: .signInButtonHeight),
            self.anonymousSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.anonymousSignInButton.bottomAnchor.constraint(equalTo: self.googleSignInButton.topAnchor, constant: .signInButtonBottomAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        self.view.addSubview(self.titleLabel)
        self.titleLabel.text = "Duel Dice"
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
    }
    
    private func configureImageView() {
        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
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

extension SignViewController {
    // MARK: - Button Action
    
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

    @objc func anonymousSignInButtonTabbed(_ sender: Any) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                return
            }
            self.isSignInSuccess(with: user.uid)
        }
    }
}

