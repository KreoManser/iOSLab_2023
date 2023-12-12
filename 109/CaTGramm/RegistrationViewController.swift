//
//  LoginViewController.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import UIKit
class RegistrationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        if UserDefaults.standard.bool(forKey: "logged") {
            self.navigationController?.pushViewController(MenuTabBarController(), animated: true)
        }

        view.backgroundColor = .white
        addSubviews(subviews: logoImageView, loginTextField, passwordTextField, loginButton, registerButton, errorLabel)
        configureUI()
    }

    private lazy var logoImageView = {
        let imageView = UIImageView(image: UIImage(named: "catLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Заполните все поля!"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Придумайте никнейм",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Придумайте пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()

    let userDefaults = UserDefaults.standard

    private lazy var loginButton: UIButton = {
        let action = UIAction(title: "login") { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        var button = UIButton(configuration: .filled())
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Есть аккаунт", for: .normal)
        return button
    }()

    private lazy var registerButton: UIButton = {
        let action = UIAction(title: "login") { (_) in
            if self.loginTextField.text != "" && self.passwordTextField.text != "" {
                var user = User(context: CoreDataManager.shared.viewContext)
                user.likes = Set<Like>()
                user.avatar = "myava"
                user.userName = self.loginTextField.text ?? ""
                user.password = self.passwordTextField.text ?? ""
                user.profileDescription = "descrip"
                user.posts = Set<Post>()
                UserManager.shared.updateUsers()
                CoreDataManager.shared.saveContext()
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.errorLabel.isHidden = false
            }
        }
        var button = UIButton(configuration: .filled())
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
}

extension RegistrationViewController {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 350),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            errorLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -10),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),

            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        errorLabel.isHidden = true
    }
}
