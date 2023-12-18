//
//  RegistrationView.swift
//  107Tukaev
//
//  Created by surexnx on 07.12.2023.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func checkUser(login: String, password: String, name: String)
}

protocol AuthDelegate: AnyObject {
    func auth()
}

class RegistrationView: UIView {

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

    lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "name"
        textField.autocapitalizationType = .none
        return textField
    }()

    lazy var registrationButton: UIButton = {

        var action = UIAction {_ in
            if let login = self.loginTextField.text, let password = self.passwordTextField.text, let name = self.nameTextField.text {
                self.delegate?.checkUser(login: login, password: password, name: name)
            }
        }

        var button = UIButton(configuration: .tinted(), primaryAction: action)
        button.setTitle("Зарегестрироваться", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var authButton: UIButton = {

        var action = UIAction {_ in
            self.authDelegate?.auth()
        }

        var button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Есть акк? Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    weak var authDelegate: AuthDelegate?
    weak var delegate: RegistrationDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(nameTextField)
        addSubview(registrationButton)
        addSubview(authButton)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var contoller = RegistrationViewController()

    func setupLayout() {

        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -60),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 25),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            nameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),

            registrationButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            registrationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            registrationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),

            authButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 25),
            authButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            authButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80)
        ])
    }
}
