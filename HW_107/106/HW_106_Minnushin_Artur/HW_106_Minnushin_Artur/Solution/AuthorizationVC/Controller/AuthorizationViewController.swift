//
//  AuthorizationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    var authorizationView = AuthorizationView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationView.authorizationVC = self
    }
    override func loadView() {
        view = authorizationView
    }
    func loginInProfile(login: String, pasword: String) {
        Task {
            let checkAthorizationData = await AuthorizationManager().asyncCheckAthorizationData(
                login: login, password: pasword,
                users: UserDataBase().getData())
            if checkAthorizationData.cheker == true {
                setupTabBar(user: checkAthorizationData.item!)
            } else {
                authorizationView.presentAllertVC()
            }
        }
    }
    func setupTabBar(user: User) {
        let tabBarController = UITabBarController()
        let profileVC = InstagramProfileViewController(user: user)
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "house.fill")
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: profileVC)
        ]
        tabBarController.modalPresentationStyle = .overFullScreen
        present(tabBarController, animated: true)
    }
}
