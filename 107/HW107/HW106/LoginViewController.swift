import UIKit

class LoginViewController: UIViewController {
    private var loginView = LoginView(frame: .zero)
    private var loginDataManager = LoginDataManager()
    private var dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareProfile()
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

        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        tabBarController.viewControllers = [mainViewController, profileViewController]
        tabBarController.selectedIndex = 1
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }

    func prepareProfile() {
        loginView.passwordTextField.delegate = loginDataManager
        loginView.loginButtonTapped = { [weak self] login, password in
            self?.loginDataManager.userExist(login: login, password: password, comeletion: { user in
                DispatchQueue.main.async {
                    if let user {
                        do {
                            try self?.dataManager.saveUser(user: user)
                            self?.dataManager.userDefaults?.setValue(true, forKey: self?.dataManager.loginBoolKey ?? "NotLoggedIn")
                        } catch {
                            print(error)
                        }
                        self?.curUserPostScreen(login: user.login, avatarImageName: user.avatarImageName)
                    } else {
                        let alert = UIAlertController(title: "Error",
                        message: "Please check input login and password. Try again!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        self?.present(alert, animated: true)
                    }
                }
            })
        }
    }
}
