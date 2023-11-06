//
//  UserLoginView.swift
//  CatGram
//
//  Created by Mac on 2023-11-02.
//

import UIKit

class UserLoginView: UIView {
    // MARK: - Declaration objects
    private let support = SupportFunctions()
    weak var controller: UserLoginViewController?

    lazy var instaLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.text = " Phone number, email, nickname"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemFill
        textField.delegate = self
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = " Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .tertiarySystemFill
        textField.delegate = self
        return textField
    }()
    lazy var loginButton: UIButton = {
        let button = support.createButton("Log in")
        return button
    }()
    lazy var signUpButton: UIButton = {
        let button = support.createButton("Sign up")
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
        setActionsForTextField()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Items Delegate
extension UserLoginView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

// MARK: - Controller-View buttons functions
extension UserLoginView {
    func setRegAction() {
        guard let controller = controller else { return }
        let regAction = controller.createRegAction()
        signUpButton.removeTarget(nil, action: nil, for: .touchUpInside)
        signUpButton.addAction(regAction, for: .touchUpInside)
    }
    func setLogAction() {
        guard let controller = controller else { return }
        let logAction = controller.createLogAction()
        loginButton.removeTarget(nil, action: nil, for: .touchUpInside)
        loginButton.addAction(logAction, for: .touchUpInside)
    }
    func getData() -> (login: String, password: String) {
        return (loginTextField.text ?? "", passwordTextField.text ?? "")
    }
    func clearData() {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
}

// MARK: - TextFields actions
extension UserLoginView {
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        setRegAction()
        setLogAction()
    }
    private func setActionsForTextField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)

        loginTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
}

// MARK: - Constraints
extension UserLoginView {
    private func setupLayouts() {
        addSubview(instaLogo)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signUpButton)

        NSLayoutConstraint.activate([
            instaLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            instaLogo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            instaLogo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            instaLogo.heightAnchor.constraint(equalToConstant: 200),

            loginTextField.topAnchor.constraint(equalTo: instaLogo.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 35),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
