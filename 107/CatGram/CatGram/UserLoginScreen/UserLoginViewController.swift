//
//  UserLoginViewController.swift
//  CatGram
//
//  Created by Mac on 2023-11-02.
//

import UIKit

class UserLoginViewController: UIViewController {
    // MARK: - Declaration objects
    private let userLoginView = UserLoginView(frame: .zero)
    private let userManager = UserManager.userManager
    private let support = SupportFunctions()

    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
    }
    override func loadView() {
        super.loadView()
        view = userLoginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginView.controller = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userLoginView.clearData()
    }
}

// MARK: - Controller-View buttons functions
extension UserLoginViewController {
    func createLogAction() -> UIAction {
        let (login, password) = userLoginView.getData()
        let trueDataAction = UIAction { [weak self] _ in
            Task {
                if await self?.checkData(login, password) ?? false {
                    if var user = self?.userManager.loginedUser {
                        let tabBar = self?.createTabBar(with: &user)
                        tabBar?.modalPresentationStyle = .fullScreen
                        if let tabBar = tabBar {
                            self?.present(tabBar, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        return trueDataAction
    }
    func createRegAction() -> UIAction {
        let (login, password) = userLoginView.getData()
        let action = UIAction { [weak self] _ in
            guard var user = self?.createUser(login, password) else { return }
            guard let tabBar = self?.createTabBar(with: &user) else { return }
            tabBar.modalPresentationStyle = .fullScreen
            self?.present(tabBar, animated: true, completion: nil)
        }
        return action
    }
    private func createTabBar(with user: inout User) -> UITabBarController {
        let newsVC = NewsViewController()
        let profileVC = MainViewController()
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        let tabBar = UITabBarController()
        let conrollers = [newsVC, profileVC]
        tabBar.viewControllers = conrollers
        tabBar.selectedIndex = 0
        return tabBar
    }
    private func createUser(_ login: String, _ password: String) -> User {
        let passwordHash = support.hashPassword(password)
        let user = User(iconUrl: nil, nick: login,
            subers: 0, subtions: 0, email: nil,
            number: nil, passHash: passwordHash,
            posts: [], destion: "new user")
        userManager.addUserAsync(user)
        return user
    }
    private func checkData(_ login: String, _ password: String) async -> Bool {
        let result = await userManager.autoriseUserAsync(login, password)
        return result
    }
}
