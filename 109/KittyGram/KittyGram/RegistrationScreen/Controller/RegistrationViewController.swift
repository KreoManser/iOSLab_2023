//
//  RegistrationViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 10.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Variables
    private lazy var registrationView = RegistrationView(frame: .zero)

    // MARK: - Lifecycle
    override func loadView() {
        view = registrationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView.controller = self
    }

}

extension RegistrationViewController {
    func presentLoginController() {

        let presentController = LoginViewController()
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }

    func registUser(_ login: String, _ password: String) {
        if login.allSatisfy({ $0.isWhitespace }) || password.allSatisfy({ $0.isWhitespace }) {
            let alert = UIAlertController(
                title: "Error",
                message: "Некорректный формат данных",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            self.present(alert, animated: true)
        } else {
            print("reg")
        }
    }

}
