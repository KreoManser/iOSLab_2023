//
//  SettingsVC.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    let settingsView = SettingsView(frame: .zero)
    let userDefaults = UserDefaults.standard
    let dataManager = DataManager.sigelton
    override func viewDidLoad() {
        settingsView.settingsVC = self
        super.viewDidLoad()
    }
    override func loadView() {
        view = settingsView
    }
    func dismisSettingsControler() {
        dismiss(animated: true, completion: nil)
    }
    func accountLogOut() {
        let navController = UINavigationController( rootViewController: LoginViewController() )
        view.addSubview( navController.view )
        userDefaults.removeObject(forKey: dataManager.user!.userName)
        dataManager.likedPost = []
        addChild( navController )
        navController.didMove( toParent: self)
    }
}
