//
//  ViewController.swift
//  Home_work_103
//
//  Created by Артур Миннушин on 24.09.2023.
//

import UIKit

class LoginViewController: UIViewController {

    lazy var loginImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loginPhoto"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        textField.textColor = UIColor(displayP3Red: 1/255, green: 1/255, blue: 1/255, alpha: 0.41)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        textField.textColor = UIColor(displayP3Red: 1/255, green: 1/255, blue: 1/255, alpha: 0.41)
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        button.backgroundColor = UIColor(displayP3Red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        button.setTitleColor(UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.41), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    let login: String = "Admin"
    let password: String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.addSubview(loginImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        setupLayoutConsrains()
        
    }
    
    @objc func loginButtonDidTap(sender: UIButton!){
        
        if loginTextField.text == login && passwordTextField.text == password{
            let vc = AccountViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupLayoutConsrains(){
        NSLayoutConstraint.activate([
            loginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            loginImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            loginImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            loginTextField.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 86),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 27),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 27),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 85),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -85),
        ])
    }
    
}

