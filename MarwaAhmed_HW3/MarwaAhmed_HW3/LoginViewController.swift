//
//  ViewController.swift
//  MarwaAhmed_HW3
//
//  Created by marwa awwad mohamed awwad on 26.09.2023.
//

import UIKit

    
class LoginViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill // scaleAspectFill for background image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 3
        tf.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.2)
        tf.textColor = UIColor(white: 0.9, alpha: 0.9)
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.autocorrectionType = .default
        // Placeholder
        let placeholder = NSAttributedString(string: "Enter your username (Admin)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.8)])
        tf.attributedPlaceholder = placeholder
        tf.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        
        return tf
    }()
    
    
    lazy var passwordTextField: UITextField = {
        let pf = UITextField()
        pf.borderStyle = .roundedRect
        pf.layer.cornerRadius = 3
        pf.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.2)
        pf.textColor = UIColor(white: 0.9, alpha: 0.9)
        pf.font = UIFont.systemFont(ofSize: 17)
        pf.autocorrectionType = .default
        // Placeholder
        let placeholder = NSAttributedString(string: "Enter your password (123)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.8)])
        pf.attributedPlaceholder = placeholder
        pf.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        return pf
        
        
    }()
    
    private lazy var passwordLabel: UILabel = {
        let view = UILabel()
        view.text = "copied"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.textColor = UIColor.black
        } else {
            textField.textColor = UIColor.purple
        }
    }
    
    @objc func passwordTextFieldDidChange(_ passwordtextField: UITextField) {
        if let text = passwordtextField.text, text.isEmpty {
            
        } else {
            passwordtextField.textColor = UIColor.purple
        }
    }

    private lazy var loginButton: UIButton = {
        var click = UIButton.Configuration.plain()
        
        click.title = "Login"
        click.baseForegroundColor = .purple
        
        return UIButton(
            configuration: click,
            primaryAction: UIAction{ [weak self] _ in
                let nextVC = productsViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
                /// Как правильно?
            })
      
    }()

    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView.init(arrangedSubviews: [usernameTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        return stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: "makeup-palette-box-iphone-12-pro-max-1")
        view.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let stackView = mainStackView()
        view.addSubview(stackView) // Add the stackView to the view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        loginButtonTapped()
        
      
        
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    }
 
    
    
    @objc func loginButtonTapped() {
        // Check if the entered username and password are correct.
        let enteredUsername = usernameTextField.text
        let enteredPassword = passwordTextField.text
        
        if enteredUsername == "Admin" && enteredPassword == "123" {
            let productViewController = productsViewController()
            navigationController?.pushViewController(productViewController, animated: true)
            
            
        } else {
            let alertController = UIAlertController(title: "Login Failed", message: "Invalid username or password.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
