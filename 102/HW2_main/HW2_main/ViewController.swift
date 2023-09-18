//
//  ViewController.swift
//  HW2_main
//
//  Created by Kseniya Skvortsova on 18.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let login="Admin"
    let password="123"
    var loginIsRight=false
    var passwordIsRight=false

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.layer.cornerRadius=loginTextField.bounds.height/2
        passwordTextField.layer.cornerRadius=passwordTextField.bounds.height/2
        loginButton.layer.cornerRadius=loginButton.bounds.height/2
        
        loginTextField.delegate=self
        passwordTextField.delegate=self
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if passwordIsRight, loginIsRight{
            performSegue(withIdentifier: "vc2", sender: Any?.self)
        }
    }
    
    //Editing did end
    @IBAction func loginEntered(_ sender: UITextField) {
        if loginTextField.text==login{
            loginIsRight=true
        }
        else{
            loginIsRight=false
        }
    }
    
    //Editing did end
    @IBAction func passwordEntered(_ sender: UITextField) {
        if passwordTextField.text==password{
            passwordIsRight=true
        }
        else{
            passwordIsRight=false
        }
    }
    
    @IBAction func unwindSegue(_ sender:UIStoryboardSegue){
        
    }
    
}

