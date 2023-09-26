//
//  ViewController.swift
//  103
//
//  Created by Dmitry on 20.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var loginTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите логин"
        return textField
    } ()
    
    lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите пароль"
        return textField
    }()
    
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "abstract")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginTF, passwordLabel, passwordTF])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(openProfilePage), for: .touchUpInside)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let login = UILabel()
        login.text = "Логин"
        return login
    }()
    
    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.text = "Пароль"
        return password
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    @objc func openProfilePage() {
        if loginTF.text == "Admin" && passwordTF.text == "123" {
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
    func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(loginPasswordStackView)
        view.addSubview(logInButton)
    }
    
    func setUpConstraints() {
        setUpImageViewConstraints()
        setUpfirstPageStackViewConstraints()
        setUpLogInButtonConstraints()
    }
    
    func setUpImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
            
        ])
    }
    
    func setUpfirstPageStackViewConstraints() {
        NSLayoutConstraint.activate([
            loginPasswordStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            loginPasswordStackView.widthAnchor.constraint(equalToConstant: 320),
            loginPasswordStackView.heightAnchor.constraint(equalToConstant: 130),
            loginPasswordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
       
    func setUpLogInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.widthAnchor.constraint(equalToConstant: 220),
            logInButton.heightAnchor.constraint(equalToConstant: 40),
            logInButton.topAnchor.constraint(equalTo: loginPasswordStackView.bottomAnchor, constant: 20),
        ])
    }
}


