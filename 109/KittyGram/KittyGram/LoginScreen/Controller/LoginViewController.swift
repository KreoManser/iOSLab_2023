//
//  LoginViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Variables
    private lazy var loginView = LoginView(frame: .zero)

    private let loginHandler = LoginHandler()

    // MARK: - Lile cycle
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.controller = self
    }

}

extension LoginViewController {

    func checkUser(_ login: String, _ password: String) {
        Task {
            if let user = await loginHandler.userVerification(login, password) {
                DataManager.shared.currentUser = user
                let tabBarController = TabBarViewController()
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true)

            } else {
                let alert = UIAlertController(
                    title: "Ой",
                    message: "Неправильный пользователь или пароль",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
                self.present(alert, animated: true)

            }
        }
    }
}
