//
//  ContentView.swift
//  MySite
//
//  Created by Timur on 23.09.2023.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(Color("Color"))
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    var loginButton: UIButton = {
        let btnTmp = ButtonTemplate()
        var loginButton = btnTmp.buttonTemplate(title: "Войти")
        return loginButton
    }()
    
    @objc func pressed (){
        let rootVC = AccountViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        if passTextField.text == "123" && loginTextField.text == "Admin" {
            present(navVC, animated: true)
        }
    }
    
    lazy var loginTextField: UITextField = {
        let sampleTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "Логин"
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        sampleTextField.backgroundColor = UIColor(Color("ButtonColor"))
        return sampleTextField
    }()
    
    var loginText: UITextView = {
        var loginText = UITextView()
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginText.text = "Логин"
        loginText.font = UIFont(name: "Inter", size: 12)
        loginText.textColor = .black
        return loginText
    }()
    lazy var passTextField: UITextField = {
        let sampleTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "Пароль"
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        sampleTextField.backgroundColor = UIColor(Color("ButtonColor"))
        return sampleTextField
    }()
    
    var passText: UITextView = {
        var loginText = UITextView()
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginText.text = "Пароль"
        loginText.font = UIFont(name: "Inter", size: 12)
        loginText.textColor = .black
        return loginText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self,
                              action: #selector(pressed),
                              for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(loginButton)
        view.addSubview(loginTextField)
        view.addSubview(passTextField)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            passTextField.heightAnchor.constraint(equalToConstant: 40),
            passTextField.widthAnchor.constraint(equalToConstant: 300),
            passTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 250),
            passTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.widthAnchor.constraint(equalToConstant: 300),
            loginTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 195),
            loginTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 327),
            imageView.heightAnchor.constraint(equalToConstant: 449),
            
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 315),
            loginButton.widthAnchor.constraint(equalToConstant: 223),
            loginButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
    
}
