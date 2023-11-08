//
//  TabViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTabBar()
        self.navigationItem.hidesBackButton = true
    }
        private func setUpTabBar() {
            let feedViewController = FeedViewController()
            let profileViewController = ProfileViewController()
            let feedNavController = UINavigationController(rootViewController: feedViewController)
            let profileNavController = UINavigationController(rootViewController: profileViewController)
            feedNavController.tabBarItem = UITabBarItem(title: nil,
                                                        image: UIImage(systemName: "house.fill")?
                .withTintColor(UIColor.systemBlue, renderingMode: .alwaysTemplate), tag: 0)
            profileNavController.tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(systemName: "person.circle.fill")?
                .withTintColor(UIColor.systemBlue, renderingMode: .alwaysTemplate), tag: 1)
            self.viewControllers = [feedNavController, profileNavController]
        }
}
