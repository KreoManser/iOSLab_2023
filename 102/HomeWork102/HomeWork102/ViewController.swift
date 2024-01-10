//
//  ViewController.swift
//  HomeWork102
//
//  Created by Ильмир Шарафутдинов on 24.12.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginText.delegate = self
        passwordText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard loginText.text == "Admin", passwordText.text == "123" else {return false}
        performSegue(withIdentifier: "vc2", sender: nil)
        return true
    }
    
    @IBAction func EenterActionButton(_ sender: Any) {
        guard loginText.text == "Admin", passwordText.text == "123" else {return}
        performSegue(withIdentifier: "vc2", sender: nil)

    }
}

