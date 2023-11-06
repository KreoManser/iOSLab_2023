//
//  AuthorizationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    var authorizationView = AuthorizationView(frame: .zero)
    var catGramVC = InstagramProfileViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationView.authorizationVC = self
    }
    override func loadView() {
        view = authorizationView
    }
    func loginInProfile(login: String, pasword: String) {
        Task {
            let checkAthorizationData = await AuthorizationManager().asyncCheckAthorizationData(
                login: login, password: pasword,
                users: UserDataBase().getData())
            if checkAthorizationData == true {
                _ = await AuthorizationManager().asyncGetCurrentUser()
                catGramVC.modalPresentationStyle = .overFullScreen
                present(catGramVC, animated: true)
            } else {
                authorizationView.presentAllertVC()
            }
        }
    }
}
