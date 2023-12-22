//
//  LoginViewController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Lile cycle

    private lazy var loginView = LoginView(frame: .zero)

    private let loginHandler = LoginHandler()

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
                let tabBarController = TabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
                await DataManager.shared.asyncSetCurrentUser(user)
                self.present(tabBarController, animated: true)

            } else {

                let alert = UIAlertController(
                    title: "opss", message: "incorrect username or password",
                preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
                self.present(alert, animated: true)

            }
        }
    }

}


