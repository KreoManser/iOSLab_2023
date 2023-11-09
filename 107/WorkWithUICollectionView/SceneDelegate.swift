//
//  SceneDelegate.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 29.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    static var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options
        connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        SceneDelegate.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: RegistrationViewController())
        SceneDelegate.window?.rootViewController = navigationController
        SceneDelegate.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
