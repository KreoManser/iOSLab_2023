//
//  SignUpView.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//

import UIKit

class SignUpView: UIView {

    private lazy var signUpLabel: UILabel = UILabel()
    lazy var selectImageButton: UIButton = UIButton()

    private lazy var loginTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()

    private lazy var signUpButton: UIButton = UIButton()

    var selectImageTapped: (() -> Void)?
    var signUpTapped: ((_ login: String, _ password: String, _ avatarImage: UIImage) -> Void)?
    var imageSelected: ((UIImage) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpLogInLabel()
        setUpSelectImageButton()
        setUploginTextField()
        setUpPasswordTextField()
        setUpSignUpButton()
    }

    private func setUpLogInLabel() {
        addSubview(signUpLabel)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.text = "Регистрация"
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 25)

        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            signUpLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func setUpSelectImageButton() {
        addSubview(selectImageButton)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        selectImageButton.layer.cornerRadius = 75
        selectImageButton.setTitle("Выбрать изображение", for: .normal)
        selectImageButton.setTitleColor(.systemBlue, for: .normal)
        selectImageButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        selectImageButton.backgroundColor = .lightGray.withAlphaComponent(0.4)
        selectImageButton.layer.borderWidth = 1
        selectImageButton.layer.borderColor = UIColor.black.cgColor
        selectImageButton.clipsToBounds = true

        selectImageButton.addAction(UIAction(handler: { [weak self] _  in
            self?.selectImageTapped?()
        }), for: .touchUpInside)

        NSLayoutConstraint.activate([
            selectImageButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            selectImageButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            selectImageButton.heightAnchor.constraint(equalToConstant: 150),
            selectImageButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setUploginTextField() {
        addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.textColor = .black
        loginTextField.layer.cornerRadius = 10
        loginTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250),
            loginTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textColor = .black
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.backgroundColor = .lightGray.withAlphaComponent(0.3)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always

        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setUpSignUpButton() {
        addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = 10
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor

        signUpButton.addAction(UIAction(handler: { [weak self] _  in
            self?.signUpTapped?(
                self?.loginTextField.text ?? "",
                self?.passwordTextField.text ?? "",
                self?.selectImageButton.image(for: .normal) ?? UIImage.question)
        }), for: .touchUpInside)

        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            signUpButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
