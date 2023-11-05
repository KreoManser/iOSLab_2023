//
//  LoginViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
    }
}
