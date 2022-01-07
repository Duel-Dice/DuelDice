//
//  SceneDelegate.swift
//  DuelDice
//
//  Created by su on 2021/10/25.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if let _ = Auth.auth().currentUser {
            let storyboard = UIStoryboard.init(name: "Client", bundle: nil)
            let gameWatingRoomViewController = storyboard.instantiateViewController(withIdentifier: "GameWaitingRoomViewController")
            window?.rootViewController=UINavigationController.init(rootViewController: gameWatingRoomViewController)
        } else {
            let signViewController = SignViewController()
            window?.rootViewController = UINavigationController(rootViewController: signViewController)
        }
        window?.makeKeyAndVisible()
    }
}

