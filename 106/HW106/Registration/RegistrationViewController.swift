//
//  RegistrationViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 06.02.2024.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    lazy var dataManager = StorageManager.shared
    var dataSource:[UserRegistration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registrationAction(_ sender: Any) {
        if passwordTextField.text == repeatPasswordTextField.text &&
            nameTextField.text?.replacingOccurrences(of: " ", with: "") != "" &&
            emailTextField.text?.replacingOccurrences(of: " ", with: "") != "" &&
            passwordTextField.text?.replacingOccurrences(of: " ", with: "") != "" {
            for user in dataManager.obtainSavedData() {
                if user.name == nameTextField.text {
                    return
                }
            }
            let user = UserRegistration(context: dataManager.viewContext)
            user.name = nameTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            dataSource.append(user)
            dataManager.saveContext()
            UserDefaults.standard.set(user.name, forKey: "currentUser")
            performSegue(withIdentifier: "vc3", sender: nil)
        }
    }
}
