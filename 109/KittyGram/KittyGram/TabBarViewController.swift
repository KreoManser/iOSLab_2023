//
//  TabBarViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 26.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    // MARK: - Variables
    let dataManager = DataManager.shared

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        try? dataManager.checkUser()
        setupTabBar()
    }

}

extension TabBarViewController {

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
