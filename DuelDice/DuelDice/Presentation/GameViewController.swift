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
    
    var me = Player()
    let play = Play()
    let timer = DiceTimer()
    let netStatus = NetStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard netStatus.isReachable() else {
            updateStatusLabelText(content: "--- [NET ERR] ---")
            return
        }
        
        me.attach(self)
        me.born()

        timer.attach(self)
        timer.beginTimer()

        play.attach(self)
//        play.requestBegin()
    }
        
    @IBAction func onClickHalf(_ sender: Any) {
        print("---- press half")
        DuelService.updateDuelRoll(of: "half") { (result) in
            print(">>>> half roll result is \(result)")
        }
    }
    
    @IBAction func onClickFull(_ sender: Any) {
        print("---- press all")
        DuelService.updateDuelRoll(of: "all") { (result) in
            print(">>>> all roll result is \(result)")
        }
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
//        guard me.detail.accessToken != nil else { return }
    }
    
    func updatePlay() {
        guard play.requestResult != nil else {
            netStatus.dispose { message in updateStatusLabelText(content: message) }
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
        let current: Int = timer.finish ? 0 : Int(CGFloat.diceTimerTimeout * 10) - Int(floor(timer.time * 10))
        
        if current == 0 {
            timer.endTimer()
            play.requestEnd(data: nil)
        }
        
        let minutes:Int = (current / 10) / 60
        let seconds:Int = (current / 10) % 60
        let mseconds:Int = current % 10
        let text:String = String(format:"%02d", minutes) + " : " + String(format: "%02d", seconds) + String(" : ") + String(format: "%01d", mseconds)
        updateStatusLabelText(content: text)
    }
}


// MARK: - DEBUG

extension GameViewController {
    
    func updateStatusLabelText(content: String) { statusLabel.text = content }
//
//    func DEBUG_LABEL_TEXT(content : String) {
//        statusLabel.text = content
//    }
}
