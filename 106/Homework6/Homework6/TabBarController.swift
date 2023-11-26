//
//  TabBarController.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class TabBarController: UITabBarController {
    private func setTabBar() async {
        let feedViewController = UINavigationController(rootViewController: setViewController(
            controller: FeedViewController(), image: UIImage(systemName: "newspaper.fill")))
        let profileViewController = UINavigationController(rootViewController: setViewController(
            controller: ProfileViewController(), image: UIImage(systemName: "person.fill")))
        setViewControllers([feedViewController, profileViewController], animated: false)
        tabBar.backgroundColor = .systemGray6
        await setNavigationBar()
    }

    private func setViewController(controller: UIViewController, image: UIImage?) -> UIViewController {
        controller.tabBarItem.image = image
        navigationController?.isNavigationBarHidden = true
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        Task {
            await setTabBar()
        }
    }
}

extension TabBarController {
    private func setNavigationBar() async {
        let profileNameLabel = UILabel()
        profileNameLabel.text = await DataManager.shared.asyncGetCurrentUser().login
        profileNameLabel.textColor = .black
        profileNameLabel.font = .boldSystemFont(ofSize: 25)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileNameLabel)

        let rightButton1 = UIButton(type: .custom)
        rightButton1.setImage(UIImage(named: "addIcon"), for: .normal)
        let firstRightBarButton = UIBarButtonItem(customView: rightButton1)

        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 20

        let rightButton2 = UIButton(type: .custom)
        rightButton2.setImage(UIImage(named: "hamburger"), for: .normal)
        let secondRightBarButton = UIBarButtonItem(customView: rightButton2)

        navigationItem.rightBarButtonItems = [secondRightBarButton, fixedSpace, firstRightBarButton]
    }
}
