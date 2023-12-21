//
//  RegistrationView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 12.12.2023.
//

import UIKit

class RegistrationView: UIView {
    weak var registratioVC: RegistrationViewController!
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()
    lazy var avatarPhotoNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя аватара"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Логин"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Пароль"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя аккаунта"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var subscriptionTetxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Описание"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 15
        textField.textColor = .white
        return textField
    }()
    lazy var registartionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Вход", for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 15
        let action = UIAction {[weak self] _ in
            self?.registrationFunc()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(avatarPhotoNameTextField)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(nameTextField)
        addSubview(subscriptionTetxtField)
        addSubview(registartionButton)
        setupSwipeRecognized()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func registrationFunc() {
        if avatarPhotoNameTextField.text == "" {
            avatarPhotoNameTextField.text = "defaultAvatar"
        }
        if loginTextField.text == "" {
            setupAlertVC(subscription: "Логин должен быть!")
            return
        }
        if passwordTextField.text == "" {
            setupAlertVC(subscription: "Пароль должен быть!")
            return
        }
        if nameTextField.text == "" {
            setupAlertVC(subscription: "Имя должен быть!")
            return
        }
        if subscriptionTetxtField.text == "" {
            setupAlertVC(subscription: "Описание должен быть!")
            return
        }
        if registratioVC.checkLogin(login: loginTextField.text!) {
            setupAlertVC(subscription: "Такой котик уже есть!")
            return
        }
        registratioVC!.registrationProfile(avatarName: avatarPhotoNameTextField.text ?? "defaultAvatar",
                                           login: loginTextField.text!,
                                           password: passwordTextField.text!,
                                           name: nameTextField.text!,
                                           subscription: subscriptionTetxtField.text!)
    }
    func setupAlertVC(subscription: String) {
        let alertVC = UIAlertController(title: "Внимание",
            message: subscription,
            preferredStyle: .alert)
        let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(cancelAlertButton)
        registratioVC?.present(alertVC, animated: true)
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.heightAnchor.constraint(equalToConstant: 170),
            avatarPhotoNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            avatarPhotoNameTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            avatarPhotoNameTextField.heightAnchor.constraint(equalToConstant: 30),
            avatarPhotoNameTextField.widthAnchor.constraint(equalToConstant: 200),
            loginTextField.topAnchor.constraint(equalTo: avatarPhotoNameTextField.bottomAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            subscriptionTetxtField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            subscriptionTetxtField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            subscriptionTetxtField.heightAnchor.constraint(equalToConstant: 30),
            subscriptionTetxtField.widthAnchor.constraint(equalToConstant: 200),
            registartionButton.topAnchor.constraint(equalTo: subscriptionTetxtField.bottomAnchor, constant: 20),
            registartionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registartionButton.heightAnchor.constraint(equalToConstant: 30),
            registartionButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupSwipeRecognized() {
        let swipeRecognized = UISwipeGestureRecognizer(target: self, action: #selector(self.handelSwipe))
        swipeRecognized.direction = .right
        addGestureRecognizer(swipeRecognized)
    }
    @objc func handelSwipe(sender: UISwipeGestureRecognizer) {
        registratioVC?.dismiss(animated: true)
    }
}
