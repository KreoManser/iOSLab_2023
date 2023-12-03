//
//  MaimController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 27.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    var profileVC = ProfileViewController()
    var newsLineVC = NewsLineViewController()
    let data = DataManager.sigelton
    init() {
        super.init(nibName: nil, bundle: nil)
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "house.fill")
        newsLineVC.tabBarItem.title = "Лента новостей"
        newsLineVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")
        modalPresentationStyle = .overFullScreen
        self.viewControllers = [
            UINavigationController(rootViewController: profileVC),
            UINavigationController(rootViewController: newsLineVC)
        ]
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
