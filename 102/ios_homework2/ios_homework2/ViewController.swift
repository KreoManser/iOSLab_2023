//
//  ViewController.swift
//  ios_homework2
//
//  Created by Аделя Миннехузина on 17.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var LoginImageView: UIImageView!
    
    @IBOutlet weak var LoginLabel: UILabel!
    
    @IBOutlet weak var LoginTextField: UITextField!
    
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    private let correctLogin = "Admin"
    private let correctPassword = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginTextField.delegate = self
        PasswordTextField.delegate = self
    }

    @IBAction func LoginButtonDidTap(_ sender: Any) {
        let login = LoginTextField.text
        let password = PasswordTextField.text
        if (password == correctPassword && login == correctLogin) {
            guard let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
}

