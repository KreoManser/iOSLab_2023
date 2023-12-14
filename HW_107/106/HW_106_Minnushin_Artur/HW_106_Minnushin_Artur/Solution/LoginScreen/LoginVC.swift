//
//  AuthorizationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    var userDefaults: UserDefaults
    let coreDataManger = CoreDataManager.shared
    var authorizationView = LoginView(frame: .zero)
    var tabBarVc: TabBarViewController?
    var registrationVC: RegistrationViewController?
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
                login: login, password: pasword)
            if checkAthorizationData.cheker == true {
                presentProfileVC(user: checkAthorizationData.item)
            } else {
                authorizationView.presentAllertVC()
            }
        }
        if coreDataManger.checkAuth(login: login, password: pasword) {
            presentProfileVC(user: coreDataManger.authorizationUser!)
        } else {
            authorizationView.presentAllertVC()
        }
    }
    func presentProfileVC(user: User) {
        userDefaults.setValue(true, forKey:
            "\(user.userName)")
        tabBarVc = TabBarViewController()
        present(tabBarVc!, animated: true)
    }
    func presentRegistrationVC() {
        registrationVC = RegistrationViewController()
        registrationVC?.modalPresentationStyle = .overFullScreen
        present(registrationVC!, animated: true)
    }
}
