//
//  LoginViewController.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import UIKit
class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addSubviews(subviews: logoImageView, loginTextField, passwordTextField, loginButton, registerButton, errorLabel)
        configureUI()
    }

    private lazy var logoImageView = {
        let imageView = UIImageView(image: UIImage(named: "catLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Неверный логин или пароль!"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ваш никнейм",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ваш пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()

    let userDefaults = UserDefaults.standard

    private lazy var loginButton: UIButton = {
        let action = UIAction(title: "login") { (_) in
            self.checkPassword()
        }
        let button = UIButton(configuration: .filled())
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        return button
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
}

extension LoginViewController {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func checkPassword() {
        var result = false
        Task {
            result = UserManager.shared.syncAuthUsers(userName: loginTextField.text ?? "a", password: passwordTextField.text ?? "a")
            if result {
                self.userDefaults.setValue(loginTextField.text, forKey: "current_user")
                DataManager.OurDataManager.currentUser = UserManager.shared.syncGetUserByName(username: loginTextField.text ?? "ТоповыйКотэ")
                self.userDefaults.setValue(true, forKey: "logged")
                self.navigationController?.pushViewController(MenuTabBarController(), animated: true)
            } else {
                self.errorLabel.isHidden = false
            }
        }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 350),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            errorLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -10),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        errorLabel.isHidden = true
    }
}
