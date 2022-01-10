//
//  Player.swift
//  DuelDice
//
//  Created by su on 2021/10/26.
//

import Foundation

class Player {
    
    lazy var observerArray = [IObserver]()
    var detail = User()
}

// MARK: - Player(implement IObserved)

extension Player: IObserved {
    
    func attach(_ observer: IObserver) { observerArray.append(observer) }
    
    func detach(_ observer: IObserver) {
        if let idx = observerArray.firstIndex(where: { $0 === observer }) {
            observerArray.remove(at: idx)
        }
    }
    
    func notify() { observerArray.forEach({ $0.update(subject: self)}) }
}

// MARK: - Set User Property

extension Player {
}

// MARK: - Born

extension Player{
    
    func born() {
        UserService.fetchUserInformation { result in
            print(result)
        }
    }
}
