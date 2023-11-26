//
//  LoginView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class LoginView: UIView {

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

    private lazy var loginButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.controller?.checkUser(
            self?.loginTextField.text ?? "",
            self?.passwordTextField.text ?? "")
        }
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Войти", for: .normal)
        return button
    }()

    private lazy var splitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "или"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private lazy var loginWithFacebookButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "f.square"), for: .normal)
        button.setTitle("  Войти через Facebook", for: .normal)
        return button
    }()

    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "У вас нет аккаунта?"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегестрируйтесь.", for: .normal)
        return button
    }()

    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registrationLabel, registrationButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Variables

    weak var controller: LoginViewController?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews(subviews: logoImageView, loginTextField, passwordTextField,
        loginButton, loginWithFacebookButton, splitLabel, footerStackView)
        configureUI()
        setupTextFields()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LoginView {
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

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),

            splitLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            splitLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),

            loginWithFacebookButton.topAnchor.constraint(equalTo: splitLabel.bottomAnchor, constant: 7),
            loginWithFacebookButton.heightAnchor.constraint(equalToConstant: 40),
            loginWithFacebookButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginWithFacebookButton.trailingAnchor.constraint(
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

extension LoginView {

    private func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTap() {
        endEditing(true)
    }

}
