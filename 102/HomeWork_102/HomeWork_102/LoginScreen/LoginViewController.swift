//
//  ViewController.swift
//  HomeWork_102
//
//  Created by Артур Миннушин on 16.09.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let login: String = "Admin"
    let password: String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginImageView.layer.cornerRadius = 20
        loginTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        loginButton.layer.cornerRadius = 8
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func authorizationChecker(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)

        if(loginTextField.text == login && passwordTextField.text == password){
            let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
}

