import UIKit

class RegistrationViewController: UIViewController {
    lazy var registrationView = RegistrationView(frame: .zero)
    override func loadView() {
        super.loadView()
        view = registrationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        registrationView.controller = self
        navigationItem.title = "Welcome to CatGram"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    func actionForButtonEnter(textLogin: String, textPassword: String) {
        Task {
            await RegistrationDataManager.shared.login(login: textLogin, password: textPassword)
            if await RegistrationDataManager.shared.getCurrentUser() != nil {
                let firstViewController = ProfileViewController()
                    firstViewController.view.backgroundColor = .white
                    firstViewController.tabBarItem = UITabBarItem(
                        title: nil,
                        image: UIImage(named: "profile"),
                        selectedImage: UIImage(named: "profile")
                    )
                let secondViewController = StoryViewController()
                    secondViewController.view.backgroundColor = .white
                    secondViewController.tabBarItem = UITabBarItem(
                        title: nil,
                        image: UIImage(named: "home"),
                        selectedImage: UIImage(named: "home")
                    )
                firstViewController.view.backgroundColor = .black
                secondViewController.view.backgroundColor = .black
            let firstNavigationController = UINavigationController(rootViewController:
                firstViewController)
            let secondNavigationController = UINavigationController(rootViewController: secondViewController)
            let tabBarController = UITabBarController()
            tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: false)

            tabBarController.tabBar.barTintColor = .black
            tabBarController.tabBar.tintColor = .white
            tabBarController.tabBar.unselectedItemTintColor = .black
            tabBarController.tabBar.backgroundColor = .darkGray
                UserDefaults.standard.setValue(true, forKey: "loggedIn")
                RegistrationDataManager.shared.saveUser()
            SceneDelegate.window?.rootViewController = tabBarController
            SceneDelegate.window?.makeKeyAndVisible()
            } else if textLogin == "" || textPassword == "" {
                registrationView.showAlert(title: "Внимание", message: "Заполните все поля")
            } else {
                registrationView.showAlert(title: "Внимание", message: "Введены некорректные данные")
            }
        }
    }
}
