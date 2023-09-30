//
//  ViewController.swift
//  HW3
//
//  Created by Kseniya Skvortsova on 27.09.2023.
//

import UIKit

class LoginViewController: UIViewController{
    
    private final let LOGIN="Admin"
    private final let PASSWORD="123"
    var loginIsRight=false
    var passwordIsRight=false

    
    private lazy var appImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginLabel: UILabel = {
        let view = UILabel()
        view.text = "Login"
        view.textColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Login"
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordLabel: UILabel = {
        let view = UILabel()
        view.text = "Password"
        view.textColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nextButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.title = "Log in"
        config.baseForegroundColor = .black

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.nextButtonTapped()
            })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .yellow
        
        configureUI()
    }

    private func nextButtonTapped() {
        if passwordTextField.text==PASSWORD, loginTextField.text==LOGIN{
            let nextVC = AccountViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

// MARK: - Autolayout
extension LoginViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func configureUI() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [loginLabel,loginTextField,passwordLabel,passwordTextField])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(appImageView, mainStackView, nextButton)

        NSLayoutConstraint.activate([
            appImageView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appImageView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 20),
            appImageView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -20),
            appImageView.heightAnchor
                .constraint(equalTo: appImageView.widthAnchor, multiplier: 1.15),

            mainStackView.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginLabel.heightAnchor.constraint(equalToConstant: loginLabel.font.lineHeight),
            passwordLabel.heightAnchor.constraint(equalToConstant: passwordLabel.font.lineHeight),

            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
}

