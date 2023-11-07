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

                let tabBarController = UITabBarController()

                let profileViewController = ProfileViewController(user)
                let feedViewController = FeedViewController(user)

                var profileImage = UIImage(named: "profileIcon")
                var homeImage = UIImage(named: "homeIcon")
                profileImage = profileImage?.resize(targetSize: CGSize(width: 30, height: 30))
                homeImage = homeImage?.resize(targetSize: CGSize(width: 30, height: 30))

                profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: profileImage, selectedImage: nil)
                feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: homeImage, selectedImage: nil)

                tabBarController.viewControllers = [profileViewController, feedViewController]

                self.navigationController?.setViewControllers([tabBarController], animated: true)
            }
        }
    }
}
