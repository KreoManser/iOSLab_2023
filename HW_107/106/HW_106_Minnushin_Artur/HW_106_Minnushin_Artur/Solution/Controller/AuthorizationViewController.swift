//
//  AuthorizationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 05.11.2023.
//

import UIKit

class AuthorizationViewController: UIViewController {
    var userDefaults: UserDefaults
    let userDataBase = UserDataBase.sigelton
    let dataManager = DataManager.sigelton
    var authorizationView = AuthorizationView(frame: .zero)
    var tabBarVc: MainController?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userDefaults.bool(forKey: "Artur Minnushin"))
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
            let checkAthorizationData = await AuthorizationManager().asyncCheckAthorizationData(
                login: login, password: pasword,
                users: userDataBase.getData())
            if checkAthorizationData.cheker == true {
                self.userDefaults.setValue(true, forKey:
                    "\(checkAthorizationData.item!.userName)")
                print("\(checkAthorizationData.item!.userName)")
                print(userDefaults.bool(forKey: "\(checkAthorizationData.item!.userName)"))
                dataManager.setupUser(user: checkAthorizationData.item!)
                tabBarVc = MainController(user: checkAthorizationData.item!)
                present(tabBarVc!, animated: true)
            } else {
                authorizationView.presentAllertVC()
            }
        }
    }
}
