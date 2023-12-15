//
//  AuthorizationView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 08.11.2023.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func verificationOfCredentials()
    func toRegistrationController()
}

class AuthorizationView: UIView {

    weak var delegate: AuthorizationViewDelegate?

    lazy var labelCatgram: UILabel = {
        let label = UILabel()
        label.text = "CatGram"
        label.font = UIFont(name: "DancingScript-Bold", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stackViewLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var fieldLogin: UITextField = {
        let field = UITextField()
        field.placeholder = "Phone number, username or email adress"
        field.autocorrectionType = .no
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    lazy var fieldPassword: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var buttonEye: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close-eye"), for: .normal)
        button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func showHideButtonTapped() {
        if fieldPassword.isSecureTextEntry {
            fieldPassword.isSecureTextEntry = false
            buttonEye.setImage(UIImage(named: "eye"), for: .normal)
        } else {
            fieldPassword.isSecureTextEntry = true
            buttonEye.setImage(UIImage(named: "close-eye"), for: .normal)
        }
    }

    lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Log in", for: .normal)
        let action = UIAction { _ in self.delegate?.verificationOfCredentials() }
        button.addAction(action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var buttonRegistration: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        let action = UIAction { _ in self.delegate?.toRegistrationController() }
        button.addAction(action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(labelCatgram)
        stackViewLogin.addArrangedSubview(fieldLogin)
        stackViewLogin.addArrangedSubview(fieldPassword)
        addSubview(stackViewLogin)
        addSubview(buttonEye)
        addSubview(buttonRegistration)
        stackViewLogin.addArrangedSubview(buttonLogin)

        NSLayoutConstraint.activate([
            labelCatgram.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            labelCatgram.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewLogin.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewLogin.topAnchor.constraint(equalTo: labelCatgram.bottomAnchor, constant: 50),

            buttonEye.centerYAnchor.constraint(equalTo: fieldPassword.centerYAnchor),
            buttonEye.trailingAnchor.constraint(equalTo: fieldPassword.trailingAnchor, constant: -10),
            buttonEye.widthAnchor.constraint(equalToConstant: 15),
            buttonEye.heightAnchor.constraint(equalToConstant: 15),
            buttonLogin.heightAnchor.constraint(equalToConstant: 35),

            buttonRegistration.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            buttonRegistration.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 30),
            buttonRegistration.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
