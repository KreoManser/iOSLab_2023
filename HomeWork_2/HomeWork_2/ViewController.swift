//
//  ViewController.swift
//  HomeWork_2
//
//  Created by Нияз Ризванов on 14.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonPress: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageText.isHidden = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
        buttonPress.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        if loginTextField.text == "Admin", passwordTextField.text == "123" {
            performSegue(withIdentifier: "switchingAccount", sender: self)
        }
        else if !loginTextField.hasText || !passwordTextField.hasText {
            showMessage(message: "Заполните все поля")
        }
        else{
            showMessage(message: "Введены некорректные данные")
        }
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func showMessage(message: String){
        messageText.alpha = 1
        messageText.isHidden = false
        messageText.text = message
        UIView.animate(withDuration: 2.0, animations: { () -> Void in self.messageText.alpha = 0
        })
    }
    
    @IBAction func chanel(segue: UIStoryboardSegue){}
}

