//
//  Timer.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/14.
//

import Foundation

class DiceTimer : IObserved {
    
    var timer = Timer()
    lazy var observerArray = [IObserver]()
    var time = DICE_TIMER_TIMEOUT
    var beginTime = Date().timeIntervalSinceReferenceDate
    var finish = false
    
    func beginTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: DICE_TIMER_INTERVAL, target: self, selector: #selector(tic), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        timer.invalidate()
        finish = true
    }
    
    @objc func tic() {
        let elapse = Date().timeIntervalSinceReferenceDate - self.beginTime
        guard elapse < DICE_TIMER_TIMEOUT else {
            endTimer()
            self.notify()
            return
        }
        
        time = elapse
        self.notify()
    }
}

// MARK: - Timer(implement IObserved)

extension DiceTimer {

    func attach(_ observer: IObserver) { observerArray.append(observer) }

    func detach(_ observer: IObserver) {
        if let idx = observerArray.firstIndex(where: { $0 === observer }) {
            observerArray.remove(at: idx)
        }
    }

    func notify() { observerArray.forEach({ $0.update(subject: self)}) }

}
