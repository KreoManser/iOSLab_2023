//
//  ViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class AuthorisationViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var authorisationImageView: UIImageView = {
        let image = UIImageView()
        image.setImage(name: "profile", cornerRadius: 10)
        return image
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: "Логин")
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.setTextField()
        return textField
        
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.setLable(title: "Пароль")
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.setTextField()
        password.isSecureTextEntry = true
        return password
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Войти")
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayouts()
    }
}

// MARK: - Support things
extension AuthorisationViewController {
    /// проверяет входные данные
    private func checkData() -> Bool {
        var resultLogin = false
        var resultPassword = false
        
        if let loginText = loginTextField.text, !loginText
            .isEmpty, loginText == "Admin" { resultLogin = true }
        if let passwordText = passwordTextField.text, !passwordText
            .isEmpty, passwordText == "123" { resultPassword = true }
        
        if resultLogin && resultPassword {
            return true
        } else {
            return false
        }
    }
}

// MARK: - ObjC
extension AuthorisationViewController {
    /// что происходит при нажатии на кнопку "войти"
    @objc func logInButtonTapped() {
        if checkData() {
            let accountVC = AccountViewController()
            navigationController?.pushViewController(accountVC, animated: true)
        } else {
            loginTextField.text = "Вы что-то ввели не так"
            passwordTextField.text = "Вы что-то ввели не так"
        }
    }
}

// MARK: - Constraints
extension AuthorisationViewController {
    
    /// добавляет констрэины
    private func setupLayouts() {
        setupAuthorisationImageView()
        setupAuthorisationStackView()
        setuplogInButton()
    }
    
    /// добавляет констреины картинки
    private func setupAuthorisationImageView() {
        
        view.addSubview(authorisationImageView)
        
        NSLayoutConstraint.activate([
            authorisationImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 327),
            authorisationImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 449),
            authorisationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorisationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            authorisationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
        ])
    }
    
    /// добавляет констреины стек вью с лейблами и текстфилдами
    private func setupAuthorisationStackView() {
        
        let authorisationStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextField, passwordLabel, passwordTextField])
        authorisationStackView.translatesAutoresizingMaskIntoConstraints = false
        authorisationStackView.spacing = 5
        authorisationStackView.axis = .vertical
        
        view.addSubview(authorisationStackView)
        
        NSLayoutConstraint.activate([
            authorisationStackView.widthAnchor.constraint(equalTo: authorisationImageView.widthAnchor),
            authorisationStackView.leadingAnchor.constraint(equalTo: authorisationImageView.leadingAnchor),
            authorisationStackView.trailingAnchor.constraint(equalTo: authorisationImageView.trailingAnchor),
            authorisationStackView.topAnchor.constraint(equalTo: authorisationImageView.bottomAnchor, constant: 10),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 33),
            passwordTextField.heightAnchor.constraint(equalToConstant: 33),
        ])
    }
    
    /// добавляет констрэины кнопке
    private func setuplogInButton() {
        view.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            logInButton.widthAnchor.constraint(equalToConstant: 223),
            logInButton.heightAnchor.constraint(equalToConstant: 33),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
