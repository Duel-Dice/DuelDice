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

var nickname_ex: String = "skysky"
var diceCount_ex: String = "16"
var highestScore_ex: String = "32"
var winCount_ex: String = "10"
var loseCount_ex: String = "4"

final class GameWaitingRoomViewController: UIViewController {
    typealias ViewChangeAction = () -> Void
    
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var delUserButton: UIButton!

    private var data: String?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var diceCount: UILabel!
    @IBOutlet weak var highestScore: UILabel!
    @IBOutlet weak var winCount: UILabel!
    @IBOutlet weak var loseCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureLabel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configure(with data: String, changeAction: @escaping ViewChangeAction) {
        print(data)
        self.data = data
    }
    
    
    // MARK: - Private
    
    private func configureLabel() {
        titleLabel.text = "🎲 DuelDice"
        nickname.text = "nickname: \(nickname_ex)"
        diceCount.text = "dice_count: \(diceCount_ex)"
        highestScore.text = "highest_score: \(highestScore_ex)"
        winCount.text = "win_count: \(winCount_ex)"
        loseCount.text = "lose_count: \(loseCount_ex)"
    }
    
    // MARK: - IBAction
    
    @IBAction func signOutButtonTabbed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        // TODO: - storyboard init 고려 필요, Sign view에 한해서 스토리보드 사용하지 않을 수도 있음..!
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signViewController = storyboard.instantiateViewController(withIdentifier: "SignViewController")
        self.navigationController?.pushViewController(signViewController, animated: true)
    }
    
    @IBAction func delUserButtonTabbed(_ sender: Any) {
<<<<<<< HEAD:DuelDice/DuelDice/Presentation/GameWaitingRoom/GameWaitingRoomViewController.swift
        let user = Auth.auth().currentUser
         
        user?.delete { error in
            if let error = error {
                print("User delete error: \(error)")
            } else {
                print("User Account Deleted!")
                
            }
        }
=======
        let user:String = "Hi"
//        let user = Auth.auth().currentUser
//
//        user?.delete { error in
//          if let error = error {
//            print("User delete error: \(error)")
//          } else {
//            print("User Account Deleted!")
//          }
//        }
         UserService.fetchUserInformation {(text) in
             print(user + text)
        }
//        func post(with idToken: String) {
//            let apiURL = "https://skyrich3.synology.me:7780/dueldice/dev/api/auth/login"
//            let param: Parameters = [
//                "firebase_jwt": idToken
//                ]
//
//            print()
//            AF.request(apiURL, method: .post, parameters: param, encoding: URLEncoding.httpBody) .validate(statusCode: 200..<300).responseString() { response in
//                switch response.result {
//                case .success:
//                    print("success")
//
//                case .failure(let error):
//                    print(error)
//                    return
//                }
//            }
//        }
//
//        let currentUser = Auth.auth().currentUser
//        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
//            guard let idToken = idToken else { return }
//            if let error = error {
//              // Handle error
//              return;
//            }
//            post(with: idToken)
//        }

>>>>>>> main:DuelDice/DuelDice/Presentation/ClientViewController.swift
    }
}
