//
//  RegistrationView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 10.12.2023.
//

import UIKit

class RegistrationView: UIView {
    // MARK: - UI elements
    private lazy var logoImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var registButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let login = self.loginTextField.text else { return }
            guard let password = self.passwordTextField.text else { return }
            self.controller?.registUser(login, password)
        }
        let button = UIButton(configuration: .filled())
        button.addAction(action, for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Зарегестрироваться", for: .normal)
        return button
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "У вас уже есть аккаунт?"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var loginButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.controller?.presentLoginController()
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitle("Войти", for: .normal)

        return button
    }()

    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Variables
    weak var controller: RegistrationViewController?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews(
            subviews: logoImageView, loginTextField,
            passwordTextField,
            registButton, footerStackView)
        configureUI()
        setupTextFields()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            logoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),

            registButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 20),
            registButton.heightAnchor.constraint(equalToConstant: 40),
            registButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 30),
            registButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -30),

            footerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            footerStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func setupTextFields() {
        loginTextField.attributedPlaceholder =
        NSAttributedString(string: " Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])

        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: " Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
    }
}

extension RegistrationView {

    private func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTap() {
        endEditing(true)
    }
}
