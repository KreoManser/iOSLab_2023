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
        firstViewController.tabBarItem.image = UIImage(systemName: "house")
        secondViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        viewControllers = [firstViewController, secondViewController]
    }

}
