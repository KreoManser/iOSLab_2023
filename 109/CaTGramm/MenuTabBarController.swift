//
//  MenuTabBarController.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import UIKit

class MenuTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let curUser = DataManager.OurDataManager.getCurrentUser()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: curUser.userName, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)], for: [])
        generateTabBar()
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: ViewController.shared, image: UIImage(systemName: "house.fill")),
            generateVC(viewController: PostlineViewController(), image: UIImage(systemName: "person.fill"))
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
}
