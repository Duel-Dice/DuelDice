//
//  Play.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/07.
//

import Foundation
import Alamofire



class Play : IObserved {

    static var requestEnable = true
    var requestResult: Duel? = nil
    let requestInterval : Double = 1.0;
    var loop = Timer()
    
    static var requestCount = 0
    let requestTimeout = 3
    
    lazy var observerArray = [IObserver]()

    
    
    func requestBegin() {
        
        if Play.requestEnable {
            loop = Timer.scheduledTimer(timeInterval: requestInterval, target: self,
                selector: #selector(networkRequest), userInfo: nil, repeats: true)
            Play.requestEnable = false
        }
    }

    
    func requestEnd(data: Duel?) {
        requestResult = data
        Play.requestEnable = true
        Play.requestCount = 0
        loop.invalidate()
    }

    
    func clearRequestResult() { requestResult = nil }

    
    @objc func networkRequest() {

        guard isOnline() else {
            self.requestEnd(data: nil)
            self.notify()
            return
        }

#if DEBUG
        print("DEBUG: pass \(requestInterval) sec")
#endif
        guard !isTimeout() else {
            self.requestEnd(data: nil)
#if DEBUG
            print("DEBUG: TimeOut")
#endif
            self.notify()
            return
        }
        
        DispatchQueue.main.async {
            let duel = self.TEST_DUEL_DATA()

            if duel.isDone {
#if DEBUG
                print("DEBUG: done")
#endif
                self.requestEnd(data: duel)
                self.notify()
            }
        }
    }
    
    
    func isTimeout() -> Bool {
        Play.requestCount += 1
        return requestTimeout <= Play.requestCount
    }
    
    
    func isOnline() -> Bool {
        return Alamofire.NetworkReachabilityManager()?.isReachable ?? false
    }

    
    
    
    

    
    func TEST_DUEL_DATA() -> Duel {
        let duel = Duel(duelId: "", userId1: "", userId2: "", dice1: [0], dice2: [0], status1: 0, status2: 0, isDone: self.TEST_RANDOM_HALF_BOOL())

        return duel
    }
    
    func TEST_RANDOM_HALF_BOOL() -> Bool {
        return Int.random(in: 0..<2) < 1 ? false : true
    }
}


// MARK: - Play(implement IObserved)

extension Play {

    func attach(_ observer: IObserver) {
        observerArray.append(observer)
    }

    func detach(_ observer: IObserver) {
        if let idx = observerArray.firstIndex(where: { $0 === observer }) {
            observerArray.remove(at: idx)
        }
    }

    func notify() {
#if DEBUG
        print("DEBUG: call notify")
#endif
        observerArray.forEach({ $0.update(subject: self)})
    }
}
