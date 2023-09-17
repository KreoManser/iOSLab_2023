//
//  LoginViewController.swift
//  Homework_2
//
//  Created by Камил Хайрутдинов on 13.09.2023.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    let adminUser = User(name: "Сергей", login: "admin", password: "123", phoneNumber: "8 800 555 3535", image: UIImage(named: "adminPicture")!)
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var loginPageView: UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        /// Обработчик нажатия на view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginPageView.addGestureRecognizer(tapGesture)
        
        /// Установка placeholder'ов через атрибуты чтобы цвет не менялся на светлой/темной темах
        let loginPlaceholderText = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        let passwordPlaceholderText = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        loginTextField.attributedPlaceholder = loginPlaceholderText
        passwordTextField.attributedPlaceholder = passwordPlaceholderText
    }
    
    // MARK: - IBActions
    @IBAction func EnrtyButtonPressed(_ sender: Any) {
        
        guard loginTextField.hasText && passwordTextField.hasText else { return }
        guard let loginText = loginTextField.text, let passwordText = passwordTextField.text else { return }
        guard !(loginText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && passwordText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) else { return }
        guard loginText == adminUser.login && passwordText == adminUser.password else { return }
        
        performSegue(withIdentifier: "showHomePageView", sender: nil)
    }
    
    @IBAction func exitToLoginViewController(_ segue: UIStoryboardSegue) { }
    
    // MARK: - Prepare func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showHomePageView" else {
            return
        }
        
        let homePageViewController = segue.destination as? HomePageViewController
        
        homePageViewController?.userImage = adminUser.image
        homePageViewController?.userName = adminUser.name
        homePageViewController?.userPhoneNumber = adminUser.phoneNumber
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
}

