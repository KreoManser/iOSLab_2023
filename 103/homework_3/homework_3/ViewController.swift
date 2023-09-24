//
//  ViewController.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    // MARK: - Variables
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var loginLabel:UILabel = {
        let lable = UILabel()
        return lable
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var passwordLabel:UILabel = {
        let lable = UILabel()
        return lable
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    // MARK: - SetUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        
    }
    
    private func setUP(){
        passwordTextField.delegate = self
        view.backgroundColor = .white
        setUpMainImageView()
        setUpLoginLabel()
        setUpLoginTextField()
        setUpPasswordLable()
        setUpPasswordTextField()
        setUpSubmitButton()
    }
    
    private func setUpMainImageView(){
        view.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.image = UIImage(named: "welcomeImage")
        mainImageView.contentMode = .scaleAspectFit 

        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            mainImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 449),
        ])
    }
    
    private func setUpLoginLabel(){
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Логин"
        loginLabel.font = UIFont.systemFont(ofSize: 12)
        
        NSLayoutConstraint.activate([
            loginLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -235),
            loginLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -160),
        ])

    }
    
    private func setUpLoginTextField(){
        view.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.font = UIFont.systemFont(ofSize: 14)
        loginTextField.backgroundColor = .opaqueSeparator
        loginTextField.layer.cornerRadius = 7
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            loginTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -198),
            loginTextField.heightAnchor.constraint(equalToConstant: 34),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 327),
        ])
    }
    
    private func setUpPasswordLable(){
        view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Пароль"
        passwordLabel.font = UIFont.systemFont(ofSize: 12)
        
        NSLayoutConstraint.activate([
            passwordLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -175),
            passwordLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -160),
        ])
    }
    
    private func setUpPasswordTextField(){
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.backgroundColor = .opaqueSeparator
        passwordTextField.layer.cornerRadius = 7
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -138),
            passwordTextField.heightAnchor.constraint(equalToConstant: 34),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 327),
        ])
    }
    
    private func setUpSubmitButton(){
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Войти", for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        submitButton.backgroundColor = .opaqueSeparator
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.layer.cornerRadius = 7
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -58),
            submitButton.heightAnchor.constraint(equalToConstant: 29),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 225)
        ])
        
        submitButton.addTarget(self, action: #selector(checkAuth), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    private func checkAuth(){
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if login == "Admin" && password == "123"{
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkAuth()
        return true
    }


}

