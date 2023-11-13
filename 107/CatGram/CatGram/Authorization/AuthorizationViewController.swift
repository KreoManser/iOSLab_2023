//
//  AuthorizationViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 08.11.2023.
//

import UIKit

class AuthorizationViewController: UIViewController, AuthorizationViewDelegate {

    private var authorizationView: AuthorizationView?
    private var authorizationDataManager: AuthorizationDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupSettings()
    }

    func verificationOfCredentials() {
        guard let login = authorizationView?.fieldLogin.text, let password = authorizationView?.fieldPassword.text else { return }
        authorizationDataManager?.loginToAccount(userName: login, password: password, completion: { user in
            DispatchQueue.main.async {
                if let user {
                    self.presentProfileController(userName: user.login, avatar: user.avatar)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancell", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        })
    }

    private func setupSettings() {
        authorizationView = AuthorizationView(frame: .zero)
        view = authorizationView
        authorizationDataManager = AuthorizationDataManager()
        authorizationView?.delegate = self
    }

    func presentProfileController(userName: String, avatar: UIImage?) {
        let tabBar: UITabBarController = UITabBarController()
        let detailController = DetailViewController(indexPath: IndexPath(row: 0, section: 0))
        let profileController = ViewController(avatarImage: avatar ?? UIImage.eye)

        let publicationsTabBarItem = UITabBarItem(title: "", image: UIImage.iconHome, selectedImage: nil)
        detailController.tabBarItem = publicationsTabBarItem
        let profileTabBarItem = UITabBarItem(title: "", image: UIImage.iconProfile, selectedImage: nil)
        profileController.tabBarItem = profileTabBarItem

        tabBar.viewControllers = [
        UINavigationController(
            rootViewController: profileController
            ),
        UINavigationController(
            rootViewController: detailController
            )
        ]
        tabBar.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(tabBar, animated: true)
    }
}

