//
//  ViewController.swift
//  David_Vasilev_HW_102
//
//  Created by Давид Васильев on 18.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if loginTextField.text == "Admin",passwordTextField.text == "123"{
            performSegue(withIdentifier: "vc2", sender: nil)
        }
        return true
    }
 
    @IBAction func clickEnter(_ sender: Any) {
        if loginTextField.text == "Admin",passwordTextField.text == "123"{
            performSegue(withIdentifier: "vc2", sender: nil)
        }
    }
    @IBAction func unwindSegueToLogin(_ sender : UIStoryboardSegue) {
        
    }

}

