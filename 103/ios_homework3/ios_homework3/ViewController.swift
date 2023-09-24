//
//  ViewController.swift
//  ios_homework3
//
//  Created by Аделя Миннехузина on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var LoginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "clouds")
        return imageView
    }()
    
    private lazy var LoginLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var PasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var LoginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var PasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var LoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .gray
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(LoginButtonDidTap), for: .touchUpInside)
        return loginButton
    }()

    private let correctLogin = "Admin"
    private let correctPassword = "123"
    
    @objc private func LoginButtonDidTap(sender: UIButton!) {
        let login = LoginTextField.text
        let password = PasswordTextField.text
        if (password == correctPassword && login == correctLogin) {
            let profileViewController = ProfileViewController()
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(LoginImageView)
        view.addSubview(LoginLabel)
        view.addSubview(LoginTextField)
        view.addSubview(PasswordLabel)
        view.addSubview(PasswordTextField)
        view.addSubview(LoginButton)
        
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            LoginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            LoginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoginImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            LoginImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38),
            
            LoginLabel.topAnchor.constraint(equalTo: LoginImageView.bottomAnchor, constant: 40),
            LoginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            LoginTextField.topAnchor.constraint(equalTo: LoginLabel.bottomAnchor, constant: 16),
            LoginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            LoginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            PasswordLabel.topAnchor.constraint(equalTo: LoginTextField.bottomAnchor, constant: 40),
            PasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            PasswordTextField.topAnchor.constraint(equalTo: PasswordLabel.bottomAnchor, constant: 16),
            PasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            PasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            LoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
            LoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
            LoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125)
        ])
    }
}

