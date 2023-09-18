//
//  ViewController.swift
//  Authorisation
//
//  Created by Mac on 2023-09-18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var registrationImageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            loginTextField.text = ""
            passwordTextField.text = ""
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        guard let findContactViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController else { return }
        
        if checkData() {
            navigationController?.pushViewController(findContactViewController, animated: true)
        }
        else {
            loginTextField.text = "Вы что-то ввели не так"
            passwordTextField.text = "Вы что-то ввели не так"
        }
    }
    
    private func checkData () -> Bool {
        var resultLogin = false
        var resultPassword = false
        
        if let loginText = loginTextField.text, !loginText.isEmpty, loginText == "Admin" {
            resultLogin = true
        }
        if let passwordText = passwordTextField.text, !passwordText.isEmpty, passwordText == "123" {
            resultPassword = true
        }
        
        if resultLogin && resultPassword { return true }
        else { return false }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

