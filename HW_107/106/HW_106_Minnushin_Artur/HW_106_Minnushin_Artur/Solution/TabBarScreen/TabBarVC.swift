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
    var peopleAccounts = PeopleAccuntsViewController()
    let data = DataManager.sigelton
    init() {
        super.init(nibName: nil, bundle: nil)
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "house.fill")
        newsLineVC.tabBarItem.title = "Лента новостей"
        newsLineVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")
        peopleAccounts.tabBarItem.title = "Поиск людей"
        peopleAccounts.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        newsLineVC.delegate = profileVC
        modalPresentationStyle = .overFullScreen
        self.viewControllers = [
            UINavigationController(rootViewController: profileVC),
            UINavigationController(rootViewController: newsLineVC),
            UINavigationController(rootViewController: peopleAccounts)
        ]
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
