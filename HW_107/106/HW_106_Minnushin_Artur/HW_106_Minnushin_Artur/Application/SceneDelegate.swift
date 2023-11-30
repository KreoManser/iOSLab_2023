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
        let data = DataManager.sigelton
        let users = UserDataBase.sigelton.getData()
        var checker = false
        users.forEach { user in
            if UserDefaults.standard.bool(forKey: user.userName) {
                data.setupUser(user: user)
                window?.rootViewController = TabBarViewController()
                checker = true
            }
        }
        if checker == false {
            window?.rootViewController = LoginViewController()
        }
        window?.makeKeyAndVisible()
    }
}