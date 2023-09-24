//
//  LoginViewController.swift
//  Homework3
//
//  Created by kerik on 23.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    lazy var  startImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.frame = CGRect(x: 0, y: 0, width: 327, height: 449)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        return label
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.frame = CGRect(x: 0, y: 0, width: 223, height: 33)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        view.addSubview(startImageView)
        view.addSubview(userNameLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        startImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            startImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startImageView.widthAnchor.constraint(equalToConstant: 327),
            startImageView.heightAnchor.constraint(equalToConstant: 449),
            
            userNameLabel.topAnchor.constraint(equalTo: startImageView.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 28),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 83),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func logInButtonTapped() {
        let profileViewController = ProfileViewController()
        
        if checkData() {
            navigationController?.pushViewController(profileViewController, animated: true)
        }
        else {
            userNameTextField.text = "Неверный логин или пароль"
            passwordTextField.text = ""
        }
    }
    
    private func checkData () -> Bool {
        if let loginText = userNameTextField.text, !loginText.isEmpty, loginText == "Admin", let passwordText = passwordTextField.text, !passwordText.isEmpty, passwordText == "123" {
            return true
        }
        else { return false }
    }
}
