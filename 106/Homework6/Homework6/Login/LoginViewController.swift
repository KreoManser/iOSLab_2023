//
//  LoginViewController.swift
//  Homework6
//
//  Created by kerik on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var loginView = LoginView(frame: .zero)
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
                    await DataManager.shared.asyncSetCurrentUser(user)
                    loginView.passwordTextField.text = .none
                    loginView.userNameTextField.text = .none
                    navigationController?.pushViewController(tabBarController, animated: true)
                    navigationController?.isNavigationBarHidden = true
                }
                self.userDefaults.setValue(true, forKey: login)
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
