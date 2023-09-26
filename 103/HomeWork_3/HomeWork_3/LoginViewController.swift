//
//  ViewController.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 23.09.2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI elements
    
    // MARK: - Image
    private lazy var appLogoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "appLogo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - TextFields
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // MARK: - Labels
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пароль"
        label.textColor = .black
        return label
    }()
    
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Логин"
        label.textColor = .black
        return label
    }()
    
    // MARK: - Button
    private lazy var loginButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.loginButtonTapped()
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(appLogoImage, loginLabel, loginTextField, passwordLabel, passwordTextField, loginButton)
        
       setupTextFields()
        
        configureUI()
        
        tapGestrure()
    }
    
    // MARK: - setup textFields func
    private func setupTextFields() {
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        loginTextField.attributedPlaceholder = NSAttributedString(string: " Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: " Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    // MARK: - Keyboard movement
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
    }
    
    /// немного objective C :)
    @objc func hideKeyboard() {
            view.endEditing(true)
    }
    
    // MARK: - Login Button Tapped
    private func loginButtonTapped() {
        guard loginTextField.hasText && passwordTextField.hasText else { return }
        guard let loginText = loginTextField.text, let passwordText = passwordTextField.text else { return }
        guard !(loginText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && passwordText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) else { return }
        guard loginText == "admin" && passwordText == "123" else { return }
        
        let profileViewController = ProfileViewController()
        profileViewController.modalPresentationStyle = .fullScreen
        present(profileViewController, animated: true, completion: nil)
    }
    
    // MARK: - view handler
    private func tapGestrure() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - extencion LoginVC
extension LoginViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    // MARK: - configureUI func
    private func configureUI() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            appLogoImage.heightAnchor.constraint(equalToConstant: 400),
            appLogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            appLogoImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            appLogoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            loginLabel.topAnchor.constraint(equalTo: appLogoImage.bottomAnchor, constant: 10),
            loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
