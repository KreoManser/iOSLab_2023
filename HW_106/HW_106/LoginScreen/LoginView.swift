//
//  LoginView.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import UIKit

class LoginView: UIView {

    private lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "InstagramLogo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        let action = UIAction {_ in
            self.controller?.loginToAccount(self.loginTextField.text ?? "", self.passwordTextField.text ?? "")
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    var controller: LoginViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {

    func setupLayout() {

        addSubview(logoImageView)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(joinButton)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),

            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),

            joinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            joinButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            joinButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor)
        ])
    }
}
