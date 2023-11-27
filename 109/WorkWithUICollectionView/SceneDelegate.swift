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
        if UserDefaults.standard.bool(forKey: "loggedIn") {
            Task {
                var user = RegistrationDataManager.shared.obtainUser()
                await RegistrationDataManager.shared.login(login: user.login, password: user.password)
                let firstViewController = ProfileViewController()
                firstViewController.view.backgroundColor = .white
                firstViewController.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "profile"),
                    selectedImage: UIImage(named: "profile")
                )
                let secondViewController = StoryViewController()
                secondViewController.view.backgroundColor = .white
                secondViewController.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "home"),
                    selectedImage: UIImage(named: "home")
                )
                firstViewController.view.backgroundColor = .black
                secondViewController.view.backgroundColor = .black
                let firstNavigationController = UINavigationController(rootViewController: firstViewController)
                let secondNavigationController = UINavigationController(rootViewController: secondViewController)
                let tabBarController = UITabBarController()
                tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: false)

                tabBarController.tabBar.barTintColor = .black
                tabBarController.tabBar.tintColor = .white
                tabBarController.tabBar.unselectedItemTintColor = .black
                tabBarController.tabBar.backgroundColor = .darkGray
                SceneDelegate.window?.rootViewController = tabBarController
                SceneDelegate.window?.makeKeyAndVisible()
            }
        } else {
            SceneDelegate.window?.rootViewController = UINavigationController(rootViewController: RegistrationViewController())
            SceneDelegate.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
