//
//  RegistrationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 12.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    let coreDataManager = CoreDataManager.shared
    let registrationView = RegistrationView()
    let userDefaults = UserDefaults.standard
    var tabBarVc: TabBarViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView.registratioVC = self
    }
    override func loadView() {
        view = registrationView
    }
    func checkLogin(login: String) -> Bool {
        return coreDataManager.loginCheck(login: login)
    }
    func registrationProfile(avatarName: String, login: String, password: String, name: String, subscription: String) {
        coreDataManager.addNewUser(login: login,
                                   password: password,
                                   name: name,
                                   subscription: subscription,
                                   avatarNmae: avatarName)
        let user = coreDataManager.getAuthorizationUser()
        userDefaults.setValue(true, forKey:
            "\(user.userName)")
        tabBarVc = TabBarViewController()
        present(tabBarVc!, animated: true)
    }
}
