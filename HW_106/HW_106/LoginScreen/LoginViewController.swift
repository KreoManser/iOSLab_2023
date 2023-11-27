//
//  LoginViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView = LoginView()

    override func loadView() {
        view = loginView
        loginView.controller = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    func loginToAccount(_ login: String, _ password: String) {
        Task {
            if let user = await UserDataManager.shared.asyncGetUser(byLogin: login, byPassword: password) {

                UserDefaults.standard.setValue(user.id, forKey: "logged_in")

                let tabBarController = UITabBarController()

                let profileController = UINavigationController(rootViewController: ProfileViewController(user))
                let feedController = UINavigationController(rootViewController: FeedViewController(user))

                var profileImage = UIImage(named: "profileIcon")
                var homeImage = UIImage(named: "homeIcon")
                profileImage = profileImage?.resize(targetSize: CGSize(width: 30, height: 30))
                homeImage = homeImage?.resize(targetSize: CGSize(width: 30, height: 30))

                profileController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, selectedImage: nil)
                feedController.tabBarItem = UITabBarItem(title: "Лента", image: homeImage, selectedImage: nil)

                tabBarController.viewControllers = [profileController, feedController]

                UIApplication.shared.windows.first?.rootViewController = tabBarController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }

    func loginToAccount(with userId: String) async -> UITabBarController {

        if let user = await UserDataManager.shared.asyncGetUser(byId: userId) {

            UserDefaults.standard.setValue(user.id, forKey: "logged_in")

            let tabBarController = UITabBarController()

            let profileController = UINavigationController(rootViewController: ProfileViewController(user))
            let feedController = UINavigationController(rootViewController: FeedViewController(user))

            var profileImage = UIImage(named: "profileIcon")
            var homeImage = UIImage(named: "homeIcon")
            profileImage = profileImage?.resize(targetSize: CGSize(width: 30, height: 30))
            homeImage = homeImage?.resize(targetSize: CGSize(width: 30, height: 30))

            profileController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, selectedImage: nil)
            feedController.tabBarItem = UITabBarItem(title: "Лента", image: homeImage, selectedImage: nil)

            tabBarController.viewControllers = [profileController, feedController]

            return tabBarController
        }
        return UITabBarController()
    }
}
