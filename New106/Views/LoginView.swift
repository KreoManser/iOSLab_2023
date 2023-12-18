//
//  LoginView.swift
//  New106
//
//  Created by Alina on 09.11.2023.
//

import UIKit

class LoginView: UIView {
    
    
    
    lazy var loginLabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  loginTextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    lazy var passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var loginButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.tintColor = .black
        let Action = UIAction { _ in
            
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(loginLabel)
        addSubview(loginTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 100),
            loginLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: 10),
            loginTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,constant: 20),
            passwordLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
