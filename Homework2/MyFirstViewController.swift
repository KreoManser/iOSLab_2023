//
//  MyFirstViewController.swift
//  HomeWork2
//
//  Created by Alina on 17.09.2023.
//

import UIKit

class MyFirstViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func correctData(login: String, password: String) -> Bool {
        let correctLogin = "Admin"
        let correctPassword = "123"
        
        return login == correctLogin && password == correctPassword
    }
    
    @IBAction func ButtonTapped(_ sender: UIButton) {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""
    
        if correctData(login: login, password: password){
            navigateToOtherScreen()
        }
    }
    
    func navigateToOtherScreen() {
            let otherViewController = MySecondViewController()
            navigationController?.pushViewController(otherViewController, animated: true)
    }
}
