//
//  Observer.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/07.
//

import Foundation

protocol IObserver : AnyObject {
    func update<T>(subject: T)
}

protocol IObserved {
    var observerArray : [IObserver] { get set }
    func attach(_ observer: IObserver)
    func detach(_ observer: IObserver)
    func notify()
}

protocol IObserve : IObserved, IObserver {}
