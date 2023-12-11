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

    let userDefaults: UserDefaults

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.userDefaults = UserDefaults.standard
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func verificationOfCredentials() {
        guard let login = authorizationView?.fieldLogin.text, let password = authorizationView?.fieldPassword.text else { return }
        authorizationDataManager?.loginToAccount(userName: login, password: password, completion: { user in
            DispatchQueue.main.async {
                if let user {
                    self.userDefaults.setValue(true, forKey: "login")
                    self.userDefaults.setValue(user.avatar?.pngData(), forKey: "avatarData")
                    _ = self.presentProfileController(avatar: user.avatar)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancell", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        })
    }

    func toRegistrationController() {
        self.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }

    private func setupSettings() {
        authorizationView = AuthorizationView(frame: .zero)
        view = authorizationView
        authorizationDataManager = AuthorizationDataManager()
        authorizationView?.delegate = self
    }

    func presentProfileController(avatar: UIImage?) -> UIViewController {
        let tabBar = UITabBarController()
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
        tabBar.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(tabBar, animated: true)
        return tabBar
    }
}

