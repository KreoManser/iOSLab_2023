//
//  RegistrationView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 07.12.2023.
//

import UIKit

class RegistrationView: UIView {

    lazy var instagramLogo: UIImageView = UIImageView()
    lazy var phoneNumberLabel: UILabel = UILabel()
    lazy var phoneNumberTextField: UITextField = UITextField()
    lazy var emailLabel: UILabel = UILabel()
    lazy var emailTextField: UITextField = UITextField()
    lazy var usernameLabel: UILabel = UILabel()
    lazy var usernameTextField: UITextField = UITextField()
    lazy var passwordLabel: UILabel = UILabel()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var interestLabel: UILabel = UILabel()
    lazy var interestTextField: UITextField = UITextField()
    lazy var redirectionLabel: UILabel = UILabel()
    lazy var redirectionButton: UIButton = UIButton()
    lazy var registerButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLogo()
        setupPhoneNumberLabel()
        setUpPhoneNumberTextField()
        setUpEmailLabel()
        setUpEmailTextField()
        setUpUserNameLabel()
        setUpUsernameTextField()
        setUpPassword()
        setUpPasswordTextField()
        setUpInterestLabel()
        setUpInterestTextField()
        setUpRegisterButton()
        setUpDirectionLabel()
        setUpDirectionButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLogo() {
        addSubview(instagramLogo)
        instagramLogo.image = UIImage(named: "logo")
        instagramLogo.translatesAutoresizingMaskIntoConstraints = false
        instagramLogo.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            instagramLogo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            instagramLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            instagramLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            instagramLogo.widthAnchor.constraint(equalToConstant: 300),
            instagramLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupPhoneNumberLabel() {
        addSubview(phoneNumberLabel)
        phoneNumberLabel.text = "PhoneNumber"
        phoneNumberLabel.textColor = .black
        phoneNumberLabel.font = UIFont.boldSystemFont(ofSize: 15)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: instagramLogo.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }

    private func setUpPhoneNumberTextField() {
        addSubview(phoneNumberTextField)
        phoneNumberTextField.placeholder = "PhoneNumber"
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.backgroundColor = .systemGray4
        phoneNumberTextField.textAlignment = .center
        phoneNumberTextField.clipsToBounds = true
        phoneNumberTextField.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpEmailLabel() {
        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email"
        emailLabel.textColor = .black
        emailLabel.font = UIFont.boldSystemFont(ofSize: 15)

        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 15),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        ])
    }

    private func setUpEmailTextField() {
        addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .systemGray4
        emailTextField.textAlignment = .center
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpUserNameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username"
        usernameLabel.textColor = .black
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 15)

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        ])
    }

    private func setUpUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = .systemGray4
        usernameTextField.clipsToBounds = true
        usernameTextField.textAlignment = .center
        usernameTextField.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            usernameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpPassword() {
        addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password"
        passwordLabel.textColor = .black
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 15)

        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        ])
    }

    private func setUpPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .systemGray4
        passwordTextField.clipsToBounds = true
        passwordTextField.textAlignment = .center
        passwordTextField.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpInterestLabel() {
        addSubview(interestLabel)
        interestLabel.translatesAutoresizingMaskIntoConstraints = false
        interestLabel.text = "Interest"
        interestLabel.textColor = .black
        interestLabel.font = UIFont.boldSystemFont(ofSize: 15)

        NSLayoutConstraint.activate([
            interestLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            interestLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)
        ])
    }

    private func setUpInterestTextField() {
        addSubview(interestTextField)
        interestTextField.translatesAutoresizingMaskIntoConstraints = false
        interestTextField.placeholder = "Interest"
        interestTextField.backgroundColor = .systemGray4
        interestTextField.clipsToBounds = true
        interestTextField.textAlignment = .center
        interestTextField.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            interestTextField.topAnchor.constraint(equalTo: interestLabel.bottomAnchor, constant: 5),
            interestTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            interestTextField.heightAnchor.constraint(equalToConstant: 40),
            interestTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    private func setUpRegisterButton() {
        addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .black
        registerButton.isEnabled = true
        registerButton.setTitleColor(.white, for: .normal)

        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: interestTextField .bottomAnchor, constant: 30),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5)
        ])
    }

    private func setUpDirectionLabel() {
        addSubview(redirectionLabel)
        redirectionLabel.translatesAutoresizingMaskIntoConstraints = false
        redirectionLabel.text = "Already have an account?"
        redirectionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        redirectionLabel.textColor = .black

        NSLayoutConstraint.activate([
            redirectionLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 5),
            redirectionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5)
        ])
    }

    private func setUpDirectionButton() {
        addSubview(redirectionButton)
        redirectionButton.setTitle("Login here", for: .normal)
        redirectionButton.translatesAutoresizingMaskIntoConstraints = false
        redirectionButton.backgroundColor = .white
        redirectionButton.isEnabled = true
        redirectionButton.setTitleColor(.blue, for: .normal)

        NSLayoutConstraint.activate([
            redirectionButton.topAnchor.constraint(equalTo: redirectionLabel.bottomAnchor, constant: 5),
            redirectionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5),
            redirectionButton.widthAnchor.constraint(equalToConstant: 100),
            redirectionButton.heightAnchor.constraint(equalToConstant: 10)

        ])
    }
}
