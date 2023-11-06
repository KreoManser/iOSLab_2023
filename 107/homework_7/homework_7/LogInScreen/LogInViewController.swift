//  LogInViewController.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import UIKit

class LogInViewController: UIViewController {

    private var logInView: LogInView?
    private var logInDataManager: LogInDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        logInDataManager = LogInDataManager()
        setUpLogInView()
        logInView?.passwordTextField.delegate = logInDataManager
        logInView?.loginTapped = { [weak self] username, password in
            self?.logInDataManager?.checkUserExists(username: username, password: password, completion: { user in
                DispatchQueue.main.async {
                    if let user {
                        self?.showPostsViewController(accountName: user.login, logoImage: user.avatarImage ?? UIImage.question)
                    } else {
                        let alert = UIAlertController(title: "Ошибка", message: "Пароль или Логин неправильные", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }

    private func setUpLogInView() {
        logInView = LogInView(frame: view.bounds)
        view = logInView
    }

    private func showPostsViewController(accountName: String, logoImage: UIImage) {
        let tbController: UITabBarController = UITabBarController()

        let postsViewController = PostsViewController(indexPath: IndexPath(row: 0, section: 0))
        let postsTabBarItem = UITabBarItem(title: "Posts", image: UIImage(named: "homeIcon"), selectedImage: nil)
        postsViewController.tabBarItem = postsTabBarItem

        let profileViewController = ProfileViewController(logoImage: logoImage)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileIcon"), selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        tbController.viewControllers = [UINavigationController(rootViewController: profileViewController),
            UINavigationController(rootViewController: postsViewController)]

        navigationController?.pushViewController(tbController, animated: true)
    }
}
