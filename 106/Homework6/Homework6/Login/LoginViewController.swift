//
//  LoginViewController.swift
//  Homework6
//
//  Created by kerik on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var loginView = LoginView(frame: .zero)

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.controller = self
    }
}

extension LoginViewController {
    func logIn(_ login: String, _ password: String) {
        Task {
            if DataManager.shared.checkData(login: login, password: password) {
                if let user = await DataManager.shared.checkUsers(login, password) {
                    let tabBarController = TabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    await DataManager.shared.asyncSetCurrentUser(user)
                    loginView.passwordTextField.text = .none
                    loginView.userNameTextField.text = .none
                    self.present(tabBarController, animated: true)
                }
            } else {
                loginView.passwordTextField.text = .none
                loginView.userNameTextField.text = .none
                let alert = UIAlertController(title: "Неверный логин или пароль", message: .none, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}
