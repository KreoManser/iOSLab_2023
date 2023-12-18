//
//  LoginView.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class LogInView: UIView {

    private lazy var logInLabel: UILabel = UILabel()

    private lazy var loginTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()

    private lazy var logInButton: UIButton = UIButton()
    private lazy var signUpButton: UIButton = UIButton()

    var loginTapped: ((_ username: String, _ password: String) -> Void)?
    var signUpTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpLogInLabel()
        setUploginTextField()
        setUpPasswordTextField()
        setUpLogInButton()
        setUpSignUpButton()
    }

    private func setUpLogInLabel() {
        addSubview(logInLabel)
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        logInLabel.text = "Авторизация"
        logInLabel.font = UIFont.boldSystemFont(ofSize: 25)

        NSLayoutConstraint.activate([
            logInLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            logInLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func setUploginTextField() {
        addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.textColor = .black
        loginTextField.layer.cornerRadius = 10
        loginTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250),
            loginTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .black
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpLogInButton() {
        addSubview(logInButton)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.layer.cornerRadius = 10
        logInButton.setTitle("Войти", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .systemBlue

        logInButton.addAction(UIAction(handler: { [weak self] _  in
            self?.loginTextField.endEditing(true)
            self?.passwordTextField.endEditing(true)
            self?.loginTapped?(self?.loginTextField.text ?? "", self?.passwordTextField.text ?? "")
            self?.passwordTextField.text = ""
        }), for: .touchUpInside)

        NSLayoutConstraint.activate([
            logInButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logInButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            logInButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpSignUpButton() {
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = 10
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor

        signUpButton.addAction(UIAction(handler: { [weak self] _  in
            self?.signUpTapped?()
        }), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
