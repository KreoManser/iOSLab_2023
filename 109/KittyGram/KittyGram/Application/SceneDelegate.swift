//
//  SceneDelegate.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if DataManager.shared.userDefaults?.bool(forKey: "loggedIn") ?? false {
            window?.rootViewController = TabBarViewController()
            window?.makeKeyAndVisible()
        } else {
            window?.rootViewController = LoginViewController()
            window?.makeKeyAndVisible()
        }
    }

}
