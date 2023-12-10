//
//  LoginView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import UIKit

class LoginView: UIView {

    lazy var loginImageView: UIImageView = UIImageView()
    lazy var userNameTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var loginButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(loginImageView)
        setUpLoginImageView()
        addSubview(userNameTextField)
        setUpUserNameTextField()
        addSubview(passwordTextField)
        setupPasswordTextField()
        setUpLoginButton()
    }

    private func setUpLoginImageView() {
        loginImageView.image = UIImage(named: "logo2")
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loginImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loginImageView.widthAnchor.constraint(equalToConstant: 200),
            loginImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 100)
        ])
    }

    private func setUpUserNameTextField() {
        userNameTextField.placeholder = "Username"
        userNameTextField.textAlignment = .center
        userNameTextField.backgroundColor = .systemGray5
        userNameTextField.layer.cornerRadius = 15
        userNameTextField.clipsToBounds = true
        userNameTextField.autocapitalizationType = .none
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 60),
            userNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.clipsToBounds = true
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpLoginButton() {
        addSubview(loginButton)
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
