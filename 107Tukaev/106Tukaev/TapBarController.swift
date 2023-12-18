//
//  TapBarController.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import UIKit

class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = UINavigationController(rootViewController: TimelineViewController())
        let secondViewController = UINavigationController(rootViewController: ProfileViewController())
        let searchViewContoller = UINavigationController(rootViewController: SearchViewController())

        firstViewController.tabBarItem.image = UIImage(systemName: "house")
        searchViewContoller.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        secondViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        viewControllers = [firstViewController, searchViewContoller, secondViewController]
    }

}
