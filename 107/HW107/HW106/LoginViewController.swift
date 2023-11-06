import UIKit

class LoginViewController: UIViewController {
    private var loginView = LoginView(frame: .zero)
    private var loginDataManager = LoginDataManager()
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

        let postViewController = PostViewController(indexPathToScroll: IndexPath(row: 0, section: 0))
        let postTabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        postViewController.tabBarItem = postTabBarItem

        let profileViewController = ProfileViewController()
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        profileViewController.tabBarItem = profileTabBarItem

        tabBarController.viewControllers = [postViewController, profileViewController]
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
                        self?.curUserPostScreen(login: user.login, avatarImageName: user.avatarImageName)
                    }
                }
            })
        }
    }
}
