//
//  ViewController.swift
//  103
//
//  Created by Alina on 24.09.2023.
//

import UIKit

class AutificationViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Photo1")
        return imageView
    }()
    
    var avatarImageConstraint: NSLayoutConstraint?
    
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Login"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.title = "Login"
        config.baseForegroundColor = .darkGray
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction {[weak self] _ in
                self?.loginButtonTapped()
            })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        
        view.backgroundColor = .white
        view.addSubview(avatarImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            avatarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 300),
        
            loginTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 50),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
         
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 70),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -70)

        ])
    }
    
    
    @objc private func loginButtonTapped() {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if login == "Admin" && password == "123" {
            let nextViewController = AuthorisationViewController()
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
