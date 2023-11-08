//
//  TabBarController.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class TabBarController: UITabBarController {
    private func setTabBar() {
        let feedViewController = UINavigationController(rootViewController: setViewController(
            controller: FeedViewController(), image: UIImage(systemName: "newspaper.fill")))
        let profileViewController = UINavigationController(rootViewController: setViewController(
            controller: ProfileViewController(), image: UIImage(systemName: "person.fill")))
        setViewControllers([feedViewController, profileViewController], animated: false)
        tabBar.backgroundColor = .systemGray6
    }

    private func setViewController(controller: UIViewController, image: UIImage?) -> UIViewController {
        controller.tabBarItem.image = image
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}
