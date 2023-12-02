//
//  LoginViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    var loginView: LoginView?
    var loginDataManager: UserDataManager?
    var feedDataManager: FeedDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        loginDataManager = UserDataManager.shared
        feedDataManager = FeedDataManager.shared
        setUpView()
        loginView?.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        loginDataManager?.didTapLoginButton = { [weak self]  in
            if let username = self?.loginView?.userNameTextField.text,
               let password = self?.loginView?.passwordTextField.text {
                self?.loginDataManager?.asyncLogin(username: username, password: password ) { result in
                    switch result {
                    case .success:
                        print("User success fully logged in")
                        let user = self?.loginDataManager?.authenticateUser(username: username, password: password)
                        let loadedUser = self?.loginDataManager?.loadUser()
                        print(loadedUser as Any)
                        FeedDataManager.shared.setCurrentUser(loadedUser)
                        DispatchQueue.main.async {
                            self?.view.subviews.forEach { $0.removeFromSuperview() }
                            self?.navigationController?.dismiss(animated: false)
//                            let tabViewController = TabViewController()
//                            self?.navigationController?.pushViewController(tabViewController, animated: true)
                            self?.showTab()

                        }
                    case .failure:
                        print("Login failed")
                    }
                }
            }
        }
        navigationItem.hidesBackButton = true

    }

    private func setUpView() {
        loginView = LoginView(frame: view.bounds)
        view = loginView
        view.backgroundColor = .white
    }

    @objc private func loginButtonTapped() {
        loginDataManager?.didTapLoginButton!()
    }
    private func showTab() {
        if let tabViewController = navigationController?.viewControllers.first(where: { $0 is TabViewController }) {
           navigationController?.popToViewController(tabViewController, animated: true)
        } else {
            let tabViewController = TabViewController()
            navigationController?.pushViewController(tabViewController, animated: true)
        }
    }

}
