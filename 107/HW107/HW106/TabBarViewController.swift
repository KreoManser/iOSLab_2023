import UIKit

class TabBarViewController: UITabBarController {
    let dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        curUserPostScreen()
    }
}

extension TabBarViewController {
    func curUserPostScreen() {
        let mainViewController = MainViewController()
        let mainTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), selectedImage: nil)
        mainViewController.tabBarItem = mainTabBarItem

        let usersViewController = UsersViewController()
        let usersTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"), selectedImage: nil)
        usersViewController.tabBarItem = usersTabBarItem

        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        setViewControllers([mainViewController, usersViewController, profileViewController], animated: true)
        selectedIndex = 2
    }
}
