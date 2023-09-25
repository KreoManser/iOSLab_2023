//
//  ViewController.swift
//  103
//
//  Created by Dmitry on 20.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var loginTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Введите логин")
        return textField
    } ()
    
    lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Введите пароль")
        return textField
    }()
    
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "appleLogo")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var firstPageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginTF, passwordLabel, passwordTF])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(openProfilePage), for: .touchUpInside)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let login = UILabel()
        login.text = "Логин"
        return login
    }()
    
    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.text = "Пароль"
        return password
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewsToMainView()
        setUpConstraints()
    }
    
    @objc func openProfilePage() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func addSubviewsToMainView() {
        view.addSubview(imageView)
        view.addSubview(firstPageStackView)
        view.addSubview(logInButton)
    }
    
    func setUpConstraints() {
        setUpImageViewConstraints()
        setUpfirstPageStackViewConstraints()
        setUpLogInButtonConstraints()
    }
    
    func setUpImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: +70),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
    }
    
    func setUpfirstPageStackViewConstraints() {
        NSLayoutConstraint.activate([
            firstPageStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: +50),
            firstPageStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            firstPageStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            firstPageStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        ])
    }
       
    func setUpLogInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: firstPageStackView.bottomAnchor, constant: +20),
            logInButton.leadingAnchor.constraint(equalTo: firstPageStackView.leadingAnchor, constant: 40),
            logInButton.trailingAnchor.constraint(equalTo: firstPageStackView.trailingAnchor, constant: -40),
            logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
}


