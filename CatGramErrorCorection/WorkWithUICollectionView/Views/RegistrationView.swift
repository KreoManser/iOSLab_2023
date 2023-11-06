//
//  RegistrationView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 03.11.2023.
//

import UIKit

class RegistrationView: UIView {
    weak var controller: RegistrationViewController?

    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.backgroundColor = .gray
        return logo
    }()
    
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите логин"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonEnter: UIButton = {
        var action = UIAction { _ in
            guard let textLogin = self.textFieldLogin.text else {return}
            guard let textPassword = self.textFieldPassword.text else {return}
            self.controller?.actionForButtonEnter(textLogin: textLogin, textPassword: textPassword)
            self.textFieldLogin.text = ""
            self.textFieldPassword.text = ""
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.backgroundColor = .systemGray4
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(logoImage)
        addSubview(buttonEnter)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout(){
        let mainStacklView1 = createVerticalStackView([labelLogin, textFieldLogin])
        let mainStacklView2 = createVerticalStackView([labelPassword, textFieldPassword])

        addSubview(mainStacklView1)
        addSubview(mainStacklView2)
        
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -150),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
       
            mainStacklView1.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            mainStacklView1.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainStacklView1.heightAnchor.constraint(equalToConstant: 60),
            mainStacklView1.widthAnchor.constraint(equalToConstant: 280),
            
            mainStacklView2.topAnchor.constraint(equalTo:
                    mainStacklView1.bottomAnchor),
            mainStacklView2.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainStacklView2.heightAnchor.constraint(equalToConstant: 60),
            mainStacklView2.widthAnchor.constraint(equalToConstant: 280),
            
            buttonEnter.topAnchor.constraint(equalTo: mainStacklView2.bottomAnchor, constant: 50),
            buttonEnter.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller?.present(alertController, animated: true, completion: nil)
    }
}
