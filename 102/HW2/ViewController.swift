//
//  ViewController.swift
//  HW2
//
//  Created by Dmitry on 17.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func logIn(_ sender: Any) {
        guard let profileViewController = storyboard?.instantiateViewController(identifier: "ProfileViewController") else { return }
        if loginTextField.text == "Admin" && passwordTextField.text == "123" {
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    
}

