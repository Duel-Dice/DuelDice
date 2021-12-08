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
    
    @IBOutlet weak var DEBUG_LABEL: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let play = Play()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let manager = Alamofire.NetworkReachabilityManager(), manager.isReachable else {
            DEBUG_LABEL_TEXT(content: "--- [NET ERR] ---")
#if DEBUG
            print("--- [NETWORK ERROR] ---")
#endif
            return
        }
        
        play.requestBegin()
        play.attach(self)
    }
}

// MARK: - Play(implement IObserver)

extension GameViewController {
    
//    override func draw(_ rect: CGRect) {
//      let path = UIBezierPath(ovalIn: rect)
//      UIColor.green.setFill()
//      path.fill()
//    }
    
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
    }
}



extension GameViewController {
    func DEBUG_LABEL_TEXT(content : String) {
        DEBUG_LABEL.text = content
    }
}
