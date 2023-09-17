//
//  ViewController.swift
//  102
//
//  Created by Кирилл Щёлоков on 17.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 8
        loginTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        welcomeImageView.image = UIImage(named: "welcomeImage")
        
        passwordTextField.delegate = self
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue){
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkAuth()
        
        return true
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        checkAuth()
    }
    
    private func checkAuth(){
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if login == "Admin" && password == "123"{
            performSegue(withIdentifier: "profileVC", sender: nil)
        }
    }
}

