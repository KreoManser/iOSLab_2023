//
//  LoginViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class LogInViewController: UIViewController {

    private var logInView: LogInView?
    private var logInDataManager: LogInDataManager?
    private var coreDataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        logInDataManager = LogInDataManager()
        setUpLogInView()
        logInView?.passwordTextField.delegate = logInDataManager
        logInView?.loginTapped = { [weak self] username, password in
            self?.logInDataManager?.checkUserExists(username: username, password: password, completion: { user in
                DispatchQueue.main.async {
                    if let user {
                        guard let imageData = user.avatarImage else {return}
                        self?.showPostsViewController(logoImage: UIImage(data: imageData) ?? UIImage.question)
                    } else {
                        let alert = UIAlertController(title: "Ошибка", message: "Пароль или Логин неправильные", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
        logInView?.signUpTapped = { [weak self] in
            self?.navigationController?.pushViewController(SignUpViewController(), animated: true)
        }
    }

    private func setUpLogInView() {
        logInView = LogInView(frame: view.bounds)
        view = logInView
    }

    public func showPostsViewController(logoImage: UIImage) {
        let tbController: UITabBarController = UITabBarController()

        let postsViewController = PostsViewController(indexPath: IndexPath(row: 0, section: 0))
        let postsTabBarItem = UITabBarItem(title: "Posts", image: UIImage(named: "homeIcon"), selectedImage: nil)
        postsViewController.tabBarItem = postsTabBarItem

        let profileViewController = ProfileViewController(logoImage: logoImage)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileIcon"), selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        tbController.viewControllers = [UINavigationController(rootViewController: postsViewController),
            UINavigationController(rootViewController: profileViewController)
            ]
        tbController.selectedIndex = 1

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tbController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
