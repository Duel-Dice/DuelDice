//
//  MatchViewController.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Alamofire



class GameViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusViewOther: UIImageView!
    @IBOutlet weak var statusViewMy: UIImageView!
    
    let play = Play()
    let windowMy = Graph(frame: CGRect(), bgColor: UIColor.systemYellow)
    let windowOther = Graph(frame: CGRect(), bgColor: UIColor.systemBrown)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let manager = Alamofire.NetworkReachabilityManager(), manager.isReachable else {
            DEBUG_LABEL_TEXT(content: "--- [NET ERR] ---")
#if DEBUG
            print("--- [NETWORK ERROR] ---")
#endif
            return
        }
        
        constraintWindow(child: windowMy, parent: statusViewMy)
        constraintWindow(child: windowOther, parent: statusViewOther)
        
        play.requestBegin()
        play.attach(self)
    }
}

// MARK: - Status Window

extension GameViewController {
    
    func constraintWindow(child : Graph, parent: UIImageView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(child)
        child.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        child.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        child.heightAnchor.constraint(equalToConstant: parent.bounds.height).isActive = true
        child.widthAnchor.constraint(equalToConstant: parent.bounds.width).isActive = true
    }
}

// MARK: - Play(implement IObserver)

extension GameViewController: IObserver {
    
    func update<Play>(subject: Play) {
#if DEBUG
        print("DEBUG: update~~")
        print("DEBUG: \(String(describing: play.requestResult?.dice1))")
        print("DEBUG: \(String(describing: play.requestResult?.dice2))")
        guard play.requestResult != nil else {
            if Alamofire.NetworkReachabilityManager() == nil {
                DEBUG_LABEL_TEXT(content: "--- [AF RMAN ERR] ---")
                print("--- [AF RMAN ERR] ---")
            }
            else if Alamofire.NetworkReachabilityManager()!.isReachable {
                DEBUG_LABEL_TEXT(content: "--- [TIME OUT] ---")
                print("--- [TIME OUT] ---")
            }
            else {
                DEBUG_LABEL_TEXT(content: "--- [NET ERR] ---")
                print("--- [NETWORK ERROR] ---")
            }
            return
        }
        
        DEBUG_LABEL_TEXT(content: "--- [DONE] ---")
        print("--- [DONE] ---")
#endif
        
        windowMy.set(animation: true)
        windowMy.set(diceNumber: play.requestResult!.dice1) // fix compare uid
        windowMy.reDraw()
        
        windowOther.set(animation: true)
        windowOther.set(diceNumber: play.requestResult!.dice2) // fix compare uid
        windowOther.reDraw()
    }
}



extension GameViewController {
    func DEBUG_LABEL_TEXT(content : String) {
        statusLabel.text = content
    }
}
