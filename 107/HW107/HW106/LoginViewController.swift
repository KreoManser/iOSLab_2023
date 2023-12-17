import UIKit

class LoginViewController: UIViewController {
    private var loginView = LoginView(frame: .zero)
    private var loginDataManager = LoginDataManager()
    private var dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.loginViewController = self
        print(dataManager.userDefaults.bool(forKey: "LoggedIn"))
    }

    override func loadView() {
        view = loginView
        view.backgroundColor = .white
    }
}

extension LoginViewController {
    func curUserPostScreen(login: String, avatarImageName: String) {
        let tabBarController: UITabBarController = UITabBarController()

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

        tabBarController.viewControllers = [mainViewController, usersViewController, profileViewController]
        tabBarController.selectedIndex = 2
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }

    func prepareProfile(login: String, password: String) {
        if loginDataManager.userExistSync(login: login, password: password) {
            let tabBarController = TabBarViewController()
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true)
        } else {
            loginView.passwordTextField.text = ""
            let alert = UIAlertController(title: "Error",
            message: "Please check input login and password. Try again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
    }
}
