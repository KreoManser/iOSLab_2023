//
//  AuthView.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import UIKit
protocol CheckAuthDelegate: AnyObject {
    func checkAuth(login: String, password: String)
}

class AuthView: UIView {

    lazy var loginTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "login"
        textField.autocapitalizationType = .none
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "password"
        textField.autocapitalizationType = .none
        return textField
    }()

    lazy var authButton: UIButton = {

        var action = UIAction {_ in
            if let login = self.loginTextField.text, let password = self.passwordTextField.text {
                self.delegate?.checkAuth(login: login, password: password)
            }
        }

        var button = UIButton(configuration: .tinted(), primaryAction: action)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var delegate: CheckAuthDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(authButton)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var contoller = AuthViewController()

    func setupLayout() {

        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 25),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            authButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            authButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            authButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80)
        ])
    }

}
