//
//  tabBarController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation
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
            controller: MainHomeViewController(),
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
