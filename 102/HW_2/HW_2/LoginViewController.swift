//
//  ViewController.swift
//  HW_2
//
//  Created by Тимур Хайруллин on 17.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let name = "Тимур Хайруллин"
    let phoneNumber = "8 800 555 3535"
    let profileImage = UIImage(named: "profile")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
  
    @IBAction func goToProfilePage(_ sender: UIButton) {
        if loginTextField.text == "Admin" && passwordTextField.text == "123" {
            performSegue(withIdentifier: "goToMyViewController", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMyViewController" {
            if let myPageVC = segue.destination as? MyPageViewController {
                myPageVC.name = name
                myPageVC.profileImage = profileImage
                myPageVC.phoneNumber = phoneNumber
            }
        }
    }
    
    @IBAction func unwindToLoginPage(_ segue: UIStoryboardSegue) {}
}
