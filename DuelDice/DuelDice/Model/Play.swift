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
    static var requestCount = 0

    var requestResult: Duel? = nil
    var loop = Timer()

    lazy var observerArray = [IObserver]()

    func requestBegin() {
        if Play.requestEnable {
            loop = Timer.scheduledTimer(timeInterval: NETWORK_REQUEST_INTERVAL, target: self,
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
        print("DEBUG: pass \(NETWORK_REQUEST_INTERVAL) sec")
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
        return NETWORK_REQUEST_TIMEOUT <= Play.requestCount
    }
    
    func isOnline() -> Bool {
        return Alamofire.NetworkReachabilityManager()?.isReachable ?? false
    }
    
}


// MARK: - Play(implement IObserved)

extension Play {

    func attach(_ observer: IObserver) { observerArray.append(observer) }

    func detach(_ observer: IObserver) {
        if let idx = observerArray.firstIndex(where: { $0 === observer }) {
            observerArray.remove(at: idx)
        }
    }

    func notify() { observerArray.forEach({ $0.update(subject: self)}) }
    
}

// MARK: - TEST

extension Play {

    func TEST_DUEL_DATA() -> Duel {
        let duel = Duel(duelId: "", userId1: "", userId2: "", dice1: TEST_RANDOM_RANGE_ARRAY(times: 16), dice2: TEST_RANDOM_RANGE_ARRAY(times: 16), status1: 0, status2: 0, isDone: TEST_RANDOM_HALF_BOOL())
        return duel
    }
    
    func TEST_RANDOM_RANGE(max: Int) -> Int {
        return Int.random(in: 1..<(max + 1));
    }

    func TEST_RANDOM_RANGE_ARRAY(times: Int) -> [Int] {
        var array = Array(repeating: 0, count: DICE_FACE_COUNT)
        
        for _ in 0..<times {
            let dice = Int.random(in: 0..<DICE_FACE_COUNT)
            array[dice] += 1
        }
        
        return array
    }

    func TEST_RANDOM_HALF_BOOL() -> Bool {
        return Int.random(in: 0..<2) < 1 ? false : true
    }
    
}
