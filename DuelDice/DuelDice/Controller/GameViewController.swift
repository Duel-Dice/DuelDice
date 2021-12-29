//
//  MatchViewController.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import UIKit
import FirebaseAuth
import GoogleSignIn



class GameViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var otherScore: UILabel!
    @IBOutlet weak var otherProgress: UILabel!
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var myProgress: UILabel!
    @IBOutlet weak var halfRoll: UIButton!
    @IBOutlet weak var fullRoll: UIButton!
    
    var me = Player()
    let play = Play()
    let timer = DiceTimer()
    let netStatus = NetStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard netStatus.isReachable() else {
            DEBUG_LABEL_TEXT(content: "--- [NET ERR] ---")
            return
        }
        
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: {token, error in
            if error != nil { assert (false) }
            let uid = Auth.auth().currentUser?.uid ?? ""
            
            self.me.detailData(uid: uid)
            self.me.detailData(token: token!)
        })

        me.attach(self)

        timer.attach(self)
        timer.beginTimer()

        play.attach(self)
        play.requestBegin()
    }
}

// MARK: - Status Window

extension GameViewController {
    
}

// MARK: - Play(implement IObserver)

extension GameViewController: IObserver {
    
    func update<T>(subject: T) {
        if subject is Play      { updatePlay() }
        if subject is Player    { updatePlayer() }
        if subject is DiceTimer { updateTimer() }
    }
    
    func updatePlayer() {
        guard me.detail.accessToken != nil else { return }
    }
    
    func updatePlay() {
        guard play.requestResult != nil else {
            netStatus.dispose { message in DEBUG_LABEL_TEXT(content: message) }
            return
        }

        var score1 = 0
        var score2 = 0
        play.requestResult?.dice1.enumerated().forEach({ (index, item) in score1 += item * (index + 1) })
        play.requestResult?.dice2.enumerated().forEach({ (index, item) in score2 += item * (index + 1) })
        
        otherScore.text = String(score1)
        myScore.text = String(score2)

        timer.endTimer()
    }
    
    func updateTimer() {
        let current: Int = timer.finish ? 0 : Int(DICE_TIMER_TIMEOUT * 10) - Int(floor(timer.time * 10))
        
        if current == 0 {
            timer.endTimer()
            play.requestEnd(data: nil)
        }
        
        let minutes:Int = (current / 10) / 60
        let seconds:Int = (current / 10) % 60
        let mseconds:Int = current % 10
        let text:String = String(format:"%02d", minutes) + " : " + String(format: "%02d", seconds) + String(" : ") + String(format: "%01d", mseconds)
        DEBUG_LABEL_TEXT(content: text)
    }
}



extension GameViewController {
    func DEBUG_LABEL_TEXT(content : String) {
        statusLabel.text = content
    }
}
