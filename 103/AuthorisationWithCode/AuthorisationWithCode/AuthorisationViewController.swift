//
//  ViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-24.
//

import UIKit

class AuthorisationViewController: UIViewController {

    lazy var authorisationImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var loginLabel: UILabel = {
        let login = UILabel()
        login.text = "Логин"
        login.font = UIFont.systemFont(ofSize: 12)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    lazy var loginTextField: UITextField = {
        var login = UITextField()
        login.font = UIFont.systemFont(ofSize: 12)
        login.backgroundColor = .lightGray
        login.layer.cornerRadius = 5
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.text = "Пароль"
        password.font = UIFont.systemFont(ofSize: 12)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var passwordTextField: UITextField = {
        var password = UITextField()
        password.font = UIFont.systemFont(ofSize: 12)
        password.backgroundColor = .lightGray
        password.layer.cornerRadius = 5
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logInButtonTapped() {
        let accountViewController = AccountViewController()
        
        if checkData() {
            navigationController?.pushViewController(accountViewController, animated: true)
        }
        else {
            loginTextField.text = "Вы что-то ввели не так"
            passwordTextField.text = "Вы что-то ввели не так"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loginTextField.text = ""
            passwordTextField.text = ""
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayouts()
    }

    
    private func checkData () -> Bool {
        var resultLogin = false
        var resultPassword = false
        
        if let loginText = loginTextField.text, !loginText.isEmpty, loginText == "Admin" {
            resultLogin = true
        }
        if let passwordText = passwordTextField.text, !passwordText.isEmpty, passwordText == "123" {
            resultPassword = true
        }
        
        if resultLogin && resultPassword { return true }
        else { return false }
    }
    
    /// добавляет констрэины
    private func setupLayouts() {
        
        let authorisationStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextField, passwordLabel, passwordTextField])
        authorisationStackView.translatesAutoresizingMaskIntoConstraints = false
        authorisationStackView.spacing = 5
        authorisationStackView.axis = .vertical
        
        view.addSubview(authorisationImageView)
        view.addSubview(authorisationStackView)
        view.addSubview(logInButton)

        NSLayoutConstraint.activate([
            authorisationImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 327),
            authorisationImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 449),
            authorisationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorisationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            authorisationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            
            authorisationStackView.widthAnchor.constraint(equalTo: authorisationImageView.widthAnchor),
            authorisationStackView.leadingAnchor.constraint(equalTo: authorisationImageView.leadingAnchor),
            authorisationStackView.trailingAnchor.constraint(equalTo: authorisationImageView.trailingAnchor),
            authorisationStackView.topAnchor.constraint(equalTo: authorisationImageView.bottomAnchor, constant: 10),
            
            
            loginTextField.heightAnchor.constraint(equalToConstant: 33),
            passwordTextField.heightAnchor.constraint(equalToConstant: 33),

            logInButton.widthAnchor.constraint(equalToConstant: 223),
            logInButton.heightAnchor.constraint(equalToConstant: 33),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
