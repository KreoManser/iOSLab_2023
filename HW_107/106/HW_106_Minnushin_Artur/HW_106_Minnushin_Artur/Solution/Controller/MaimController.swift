//
//  MaimController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 27.11.2023.
//

import UIKit

class MainController: UITabBarController {
    var profileVC: InstagramProfileViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(user: User) {
        self.profileVC = InstagramProfileViewController(user: user)
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "house.fill")
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [
            UINavigationController(rootViewController: profileVC)
        ]
        modalPresentationStyle = .overFullScreen
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
