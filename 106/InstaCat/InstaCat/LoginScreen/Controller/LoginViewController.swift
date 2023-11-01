//
//  LoginViewController.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 01.11.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Lile cycle

    private lazy var loginView = LoginView(frame: .zero)

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.controller = self
    }

}

