import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        try? DataManager.shared.checkUser()
        curUserPostScreen()
    }
}

extension TabBarViewController {
    func curUserPostScreen() {
        let mainViewController = MainViewController()
        let mainTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), selectedImage: nil)
        mainViewController.tabBarItem = mainTabBarItem

        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        setViewControllers([mainViewController, profileViewController], animated: true)
        selectedIndex = 1
    }
}
