//
//  ViewController.swift
//  HW_102
//
//  Created by Азат Зиганшин on 17.09.2023.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginImage.layer.cornerRadius = 10
        loginImage.clipsToBounds = true
    }
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        if loginTextField.text == "Admin" && passwordTextField.text == "123" {
            performSegue(withIdentifier: "LoginSeque", sender: nil)
        }
    }
    @IBAction func unwindToViewController(_ sender: UIStoryboardSegue){
        
    }
}

