//
//  TabBarController.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 04.11.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

}

extension TabBarController {
    private func setupTabBar() {
        setViewControllers([
            setupViewController(
            controller: MainFeedViewController(),
            image: UIImage(systemName: "house.fill")),

            setupViewController(
            controller: ProfileViewController(),
            image: UIImage(systemName: "person.crop.circle"))
        ], animated: true)

        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
    }

    private func setupViewController(controller: UIViewController, image: UIImage?) -> UIViewController {
        controller.tabBarItem.image = image
        return controller
    }
}
