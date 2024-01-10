//
//  ViewController.swift
//  IosHW103
//
//  Created by Ильмир Шарафутдинов on 02.01.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let mainImageViewConstant = "voy"
    let imageViewTopAncorConstant = 140
    let imageViewWidthConstant = 449
    let imageViewHeightConstant = 327
    let carImageRightConstrain = 32
    let loginLabelTopAncorConstraints = 125
    let fontSizeLabel = 13
    let loginFieldTopAncorConstraints = 3
    let loginFieldWidthConstant = 329
    let fontSizeTextField = 14
    let loginPlaceholder = "Логин"
    let passwordLabelTopAncorConstraints = 5
    let passwordPlaceholder = "Пароль"
    let entranceButtonWidthAnchorConstraints = 223
    let buttonSetTitle = "Войти"
    let loginConstant = "Admin"
    let passwordConstant = "123"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: mainImageViewConstant))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var loginlabel: UILabel = {
        let login = UILabel()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        return login
    }()
    
    lazy var passwordlabel: UILabel = {
        let password = UILabel()
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    lazy var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        return login
    }()
    
    lazy var passwordField: UITextField = {
        
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false

        return password
    }()
    
    lazy var entranceButton: UIButton = {
        let entrance = UIButton()
        entrance.translatesAutoresizingMaskIntoConstraints = false
        
        return entrance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .white
        setupLayout()
    }
    

    
    func setupLayout() {
        imageView.contentMode = .scaleAspectFit
        
        loginlabel.text = loginPlaceholder
        loginlabel.font = UIFont.systemFont(ofSize: CGFloat(fontSizeLabel))
        passwordlabel.text = passwordPlaceholder
        passwordlabel.font = UIFont.systemFont(ofSize: CGFloat(fontSizeLabel))
        
        entranceButton.setTitle(buttonSetTitle, for: .normal)
        entranceButton.backgroundColor = .lightGray
        entranceButton.setTitleColor(.black, for: .normal)
        entranceButton.addTarget(self, action: #selector(self.buttonTaped), for: .touchUpInside)

        loginField.backgroundColor = .lightGray
        passwordField.backgroundColor = .lightGray
        loginField.placeholder = loginPlaceholder
        passwordField.placeholder = passwordPlaceholder
        loginField.borderStyle = UITextField.BorderStyle.roundedRect
        loginField.font = UIFont.systemFont(ofSize: CGFloat(fontSizeTextField))
        passwordField.font = UIFont.systemFont(ofSize: CGFloat(fontSizeTextField))
        passwordField.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        view.addSubview(imageView)
        view.addSubview(loginlabel)
        view.addSubview(passwordlabel)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(entranceButton)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(imageViewWidthConstant)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageViewHeightConstant)),
            
            loginlabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat(loginLabelTopAncorConstraints)),
            loginlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(carImageRightConstrain)),
            loginlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-carImageRightConstrain)),
            
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(carImageRightConstrain)),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat(-carImageRightConstrain)),
            loginField.topAnchor.constraint(equalTo: loginlabel.bottomAnchor, constant: CGFloat(loginFieldTopAncorConstraints)),
            loginField.widthAnchor.constraint(equalToConstant: CGFloat(loginFieldWidthConstant)),
            loginField.heightAnchor.constraint(equalToConstant: CGFloat(carImageRightConstrain)),
            
            passwordlabel.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: CGFloat(passwordLabelTopAncorConstraints)),
            passwordlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(carImageRightConstrain)),
            passwordlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(carImageRightConstrain)),
            
            passwordField.topAnchor.constraint(equalTo: passwordlabel.bottomAnchor, constant: 3),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(carImageRightConstrain)),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(carImageRightConstrain)),
            passwordField.widthAnchor.constraint(equalToConstant: CGFloat(loginFieldWidthConstant)),
            passwordField.heightAnchor.constraint(equalToConstant: CGFloat(carImageRightConstrain)),
            
            entranceButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: CGFloat(carImageRightConstrain)),
            entranceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entranceButton.widthAnchor.constraint(equalToConstant: CGFloat(entranceButtonWidthAnchorConstraints)),
            entranceButton.heightAnchor.constraint(equalToConstant: CGFloat(carImageRightConstrain))
            
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard loginField.text == loginConstant, passwordField.text == passwordConstant else {return false}
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
        return true
    }
    
    @objc func buttonTaped() {
        guard loginField.text == loginConstant, passwordField.text == passwordConstant else { return }
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

