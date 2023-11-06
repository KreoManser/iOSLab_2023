//
//  TapBarController.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import UIKit

class TapBarController: UITabBarController {

    var userImage: UIImage

    init(userImage: UIImage) {
        self.userImage = userImage
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let firstViewController = TimelineViewController()
        let secondViewController = ProfileViewController()
        firstViewController.tabBarItem.image = UIImage(systemName: "house")
        secondViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        viewControllers = [firstViewController, secondViewController]
    }

}
