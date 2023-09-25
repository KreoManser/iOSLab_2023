//
//  ViewController.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var labelPassword: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonEnter: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(logoImage)
        view.addSubview(buttonEnter)
        
        if let image = UIImage(named: "logo_in_technology"){
            logoImage.image = image
        }
        
        buttonEnter.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        navigationItem.title = "Welcome to IN TECHNOLOGY"
        
        configureElement()
        
        setupLayout()
    }
    
    private func configureElement(){        
        labelLogin.text = "Логин"
        labelLogin.textColor = .black
        
        textFieldLogin.placeholder = "Введите логин"
        textFieldLogin.backgroundColor = .systemGray4
        textFieldLogin.layer.cornerRadius = 4
        textFieldLogin.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textFieldLogin.leftViewMode = .always
        
        labelPassword.text = "Пароль"
        labelPassword.textColor = .black
        
        textFieldPassword.placeholder = "Введите пароль"
        textFieldPassword.backgroundColor = .systemGray4
        textFieldPassword.layer.cornerRadius = 4
        textFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textFieldPassword.leftViewMode = .always
        textFieldPassword.isSecureTextEntry = true
        
        buttonEnter.backgroundColor = .systemGray4
        buttonEnter.setTitle("Войти", for: .normal)
        buttonEnter.setTitleColor(.black, for: .normal)
        
    }
    
    private func setupLayout(){
        let mainStacklView_1 = createVerticalStackView([labelLogin, textFieldLogin])
        let mainStacklView_2 = createVerticalStackView([labelPassword, textFieldPassword])

        view.addSubview(mainStacklView_1)
        view.addSubview(mainStacklView_2)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImage.heightAnchor.constraint(equalToConstant: 300),
            logoImage.widthAnchor.constraint(equalToConstant: 300),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            mainStacklView_1.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            mainStacklView_1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            mainStacklView_1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            mainStacklView_1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStacklView_1.heightAnchor.constraint(equalToConstant: 60),
            mainStacklView_1.widthAnchor.constraint(equalToConstant: 280),
            
            mainStacklView_2.topAnchor.constraint(equalTo:
                    mainStacklView_1.bottomAnchor),
//            mainStacklView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            mainStacklView_2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainStacklView_2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStacklView_2.heightAnchor.constraint(equalToConstant: 60),
            mainStacklView_2.widthAnchor.constraint(equalToConstant: 280),
            
            buttonEnter.topAnchor.constraint(equalTo: mainStacklView_2.bottomAnchor, constant: 50),
            buttonEnter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonEnter.heightAnchor.constraint(equalToConstant: 38),
            buttonEnter.widthAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
    
     @objc func buttonTapped() {
        if textFieldLogin.text == "Admin", textFieldPassword.text == "123" {
            navigationController?.pushViewController(AccountViewController(), animated: true)
        }
        else if !textFieldLogin.hasText || !textFieldPassword.hasText {
            showAlert(title: "Внимание", message: "Заполните все поля")
        }
        else{
            showAlert(title: "Внимание", message: "Введены некорректные данные")
        }
         
        textFieldLogin.text = ""
        textFieldPassword.text = ""
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


