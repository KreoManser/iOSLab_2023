//
//  AuthorizationView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class AuthorizationView: UIView {
    var authorizationVC: AuthorizationViewController?
    lazy var authorizationLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        return image
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedText = NSAttributedString(
            string: "Логин",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var paswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedText = NSAttributedString(
            string: "Пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var autohorizationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Вход", for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 15
        let action = UIAction {[weak self] _ in
            self?.loginInVC()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(authorizationLogo)
        addSubview(loginTextField)
        addSubview(paswordTextField)
        addSubview(autohorizationButton)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            authorizationLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            authorizationLogo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            authorizationLogo.widthAnchor.constraint(equalToConstant: 300),
            authorizationLogo.heightAnchor.constraint(equalToConstant: 170),
            loginTextField.topAnchor.constraint(equalTo: authorizationLogo.bottomAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.widthAnchor.constraint(equalToConstant: 200),
            paswordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            paswordTextField.heightAnchor.constraint(equalToConstant: 30),
            paswordTextField.widthAnchor.constraint(equalToConstant: 200),
            paswordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            autohorizationButton.topAnchor.constraint(equalTo: paswordTextField.bottomAnchor, constant: 30),
            autohorizationButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            autohorizationButton.heightAnchor.constraint(equalToConstant: 30),
            autohorizationButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func loginInVC() {
        authorizationVC?.loginInProfile(login: loginTextField.text!, pasword: loginTextField.text!)
    }
    func presentAllertVC() {
        let alertVC = UIAlertController(title: "Упс...",
            message: "Неверный логин или пароль. Как вспомнишь, приходи :)",
            preferredStyle: .alert)
        let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(cancelAlertButton)
        authorizationVC?.present(alertVC, animated: true)
    }
}
