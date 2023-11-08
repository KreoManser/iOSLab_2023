//
//  LoginView.swift
//  Homework6
//
//  Created by kerik on 05.11.2023.
//

import UIKit

class LoginView: UIView {
    private lazy var  startImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray3
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var loginAndPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, userNameTextField, passwordLabel, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var loginButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.controller?.logIn(
                self?.userNameTextField.text ?? "",
                self?.passwordTextField.text ?? ""
            )
        }

        let button = UIButton(type: .system)
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 223, height: 33)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var controller: LoginViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        addSubviews(subviews: startImageView, loginAndPasswordStackView, loginButton)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            startImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            startImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            startImageView.widthAnchor.constraint(equalToConstant: 300),
            startImageView.heightAnchor.constraint(equalToConstant: 300),

            loginAndPasswordStackView.topAnchor.constraint(equalTo: startImageView.bottomAnchor, constant: 20),
            loginAndPasswordStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            loginAndPasswordStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            loginButton.topAnchor.constraint(equalTo: loginAndPasswordStackView.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 223),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
