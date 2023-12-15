//
//  LoginViewController.swift
//  New106
//
//  Created by Alina on 09.11.2023.
//

import UIKit

class LoginViewController: UITabBarController {
    
    private var loginView: LoginView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupLoginView()

        // Do any additional setup after loading the view.
    }
    

    private func setupLoginView() {
        loginView = LoginView(frame: view.bounds)
    }

}
