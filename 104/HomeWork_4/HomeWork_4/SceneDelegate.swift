//
//  SceneDelegate.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 27.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: ToDoTasksViewController())
        window?.makeKeyAndVisible()
    }
}

