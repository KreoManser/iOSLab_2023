//
//  SceneDelegate.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let users = UserDataBase.sigelton.getData()
        let viewController = AuthorizationViewController()
        var navigationVC = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationVC
        users.forEach { user in
            if UserDefaults.standard.bool(forKey: user.userName) {
                DataManager.sigelton.setupUser(user: user)
                navigationVC = UINavigationController(rootViewController: MainController(user: user))
                window?.rootViewController = navigationVC
                UserDefaults.standard.removeObject(forKey: user.userName)
            }
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
