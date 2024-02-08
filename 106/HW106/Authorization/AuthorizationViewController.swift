//
//  AuthorizationViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 02.02.2024.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    var dataManager = StorageManager.shared
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func enterButton(_ sender: Any) {
        for user in dataManager.obtainSavedData() {
            if loginTextField.text == user.name && passwordTextField.text == user.password {
                UserDefaults.standard.set(user.name, forKey: "currentUser")
                performSegue(withIdentifier: "vc2", sender: nil)
                break
            }
        }
    }
    
    @IBAction func registrationViewPresentButton(_ sender: Any) {
        performSegue(withIdentifier: "registration", sender: nil)
    }
    
}
