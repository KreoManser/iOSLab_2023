//
//  AuthorizationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    var userDefaults: UserDefaults
    let userDataBase = UserDataBase.sigelton
    let dataManager = DataManager.sigelton
    var authorizationView = LoginView(frame: .zero)
    var tabBarVc: TabBarViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationView.authorizationVC = self
    }
    init() {
        self.userDefaults = UserDefaults.standard
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = authorizationView
    }
    func loginInProfile(login: String, pasword: String) {
        Task {
            let checkAthorizationData = await LoginManager().asyncCheckAthorizationData(
                login: login, password: pasword,
                users: userDataBase.getData())
            if checkAthorizationData.cheker == true {
                presentVc(user: checkAthorizationData.item!)
            } else {
                authorizationView.presentAllertVC()
            }
        }
    }
    func presentVc(user: User) {
        userDefaults.setValue(true, forKey:
            "\(user.userName)")
        dataManager.setupUser(user: user)
        tabBarVc = TabBarViewController()
        present(tabBarVc!, animated: true)
    }
}
