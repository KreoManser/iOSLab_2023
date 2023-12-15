//
//  RegistrationView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 07.12.2023.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    func popViewController()
    func saveСredentials()
}

class RegistrationView: UIView {

    weak var delegate: RegistrationViewDelegate?

    lazy var labelCatgram: UILabel = {
        let label = UILabel()
        label.text = "CatGram"
        label.font = UIFont(name: "DancingScript-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var catImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.kitRegister
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
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

    lazy var duplicateFieldPassword: UITextField = {
        let field = UITextField()
        field.placeholder = "Duplicate password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var buttonSignUp: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Sign Up", for: .normal)
        let action = UIAction { _ in self.delegate?.saveСredentials() }
        button.addAction(action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var buttonBack: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.setTitle("Back", for: .normal)
        let action = UIAction { _ in self.delegate?.popViewController() }
        button.addAction(action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        backgroundColor = .white
        addSubview(labelCatgram)
        addSubview(catImage)
        stackViewLogin.addArrangedSubview(fieldLogin)
        stackViewLogin.addArrangedSubview(fieldPassword)
        stackViewLogin.addArrangedSubview(duplicateFieldPassword)
        stackViewLogin.addArrangedSubview(buttonSignUp)
        addSubview(buttonBack)
        addSubview(stackViewLogin)

        NSLayoutConstraint.activate([

            labelCatgram.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            labelCatgram.centerXAnchor.constraint(equalTo: centerXAnchor),
            catImage.topAnchor.constraint(equalTo: labelCatgram.bottomAnchor, constant: 20),
            catImage.centerXAnchor.constraint(equalTo: centerXAnchor),

            stackViewLogin.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewLogin.topAnchor.constraint(equalTo: catImage.bottomAnchor, constant: 50),

            buttonBack.topAnchor.constraint(equalTo: stackViewLogin.bottomAnchor, constant: 30),
            buttonBack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
