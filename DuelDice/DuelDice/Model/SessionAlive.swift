//
//  SessionAlive.swift
//  DuelDice
//
//  Created by kyuhkim on 2022/01/09.
//

import Foundation

class SessionAlive: IObserved {
    var timer = Timer()
    lazy var observerArray = [IObserver]()
    var time = DICE_TIMER_TIMEOUT
    var beginTime = Date().timeIntervalSinceReferenceDate
    var finish = false

    func beginTimer() {
        timer = Timer.scheduledTimer(timeInterval: NETWORK_REQUEST_INTERVAL, target: self, selector: #selector(tic), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        timer.invalidate()
        finish = true
    }
    
    @objc func tic() {
        DuelService.fetchDuelInformation { result in
            print("duel info")
            print(result)
            if (true) { self.notify() }
            // is game expired
        }
    }
}

// MARK: - Timer(implement IObserved)

extension SessionAlive {

    func attach(_ observer: IObserver) { observerArray.append(observer) }

    func detach(_ observer: IObserver) {
        if let idx = observerArray.firstIndex(where: { $0 === observer }) {
            observerArray.remove(at: idx)
        }
    }

    func notify() { observerArray.forEach({ $0.update(subject: self)}) }

}
