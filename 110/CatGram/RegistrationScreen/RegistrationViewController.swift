//
//  RegistrationViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 07.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    var registrationView: RegistrationView?
    var userDataMananger: UserDataManager?
    var registrationDataManager: RegistrationDataManager?
    var coreDataManager: CoreDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        registrationDataManager = RegistrationDataManager.shared
        userDataMananger = UserDataManager.shared
        userDataMananger?.coreDataManager = CoreDataManager.shared
        setUpView()

        registrationView?.registerButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        registrationView?.redirectionButton.addTarget(self, action: #selector(redirectionButtonTapped), for: .touchUpInside)

        registrationDataManager?.didTapRegisterButton = { [weak self] in
            if let username = self?.registrationView?.usernameTextField.text, let interest = self?.registrationView?.interestTextField.text,
               let email = self?.registrationView?.emailTextField.text,
                  let password = self?.registrationView?.passwordTextField.text {
                self?.userDataMananger?.asyncRegisterUser(username: username, password: password, interest: interest, email: email) { result in
                    switch result {
                    case.success:
                        print("user sucessfully registered")
                        DispatchQueue.main.async {
                            print("naivgating to login")
                            let loginviewController = LoginViewController()
                           self?.navigationController?.pushViewController(loginviewController, animated: true)
                        }
                    case .failure:
                        print("user not registered ")
                    }
                }
            }
        }

        registrationDataManager?.didTapRedirectionButton = { [weak self] in
            let loginViewController = LoginViewController()
            self?.navigationController?.pushViewController(loginViewController, animated: true)
        }

        registrationView?.emailTextField.autocapitalizationType = .none
        navigationItem.hidesBackButton = true
    }

    private func setUpView() {
        registrationView = RegistrationView(frame: view.bounds)
        view = registrationView
        view.backgroundColor = .white
    }

    @objc private func registrationButtonTapped() {
        registrationDataManager?.didTapRegisterButton!()
    }
    @objc private func redirectionButtonTapped() {
        registrationDataManager?.didTapRedirectionButton!()
    }
}
