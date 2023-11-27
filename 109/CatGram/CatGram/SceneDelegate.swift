import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var tabBarController = UITabBarController()
    let dataManager = DataManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        if UserDefaults.standard.bool(forKey: "logged_in") {

            let feedViewController = FeedViewController()
            let feedNavigationController = UINavigationController(rootViewController: feedViewController)
            feedViewController.user = dataManager.obtainUserByLogin()
            feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)

            let profileViewController = ProfileViewController()
            let profileNavigationController = UINavigationController(rootViewController: profileViewController)
            profileViewController.user = dataManager.obtainUserByLogin()
            profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 1)

            tabBarController.viewControllers = [feedNavigationController, profileNavigationController]

            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        } else {
            let authViewController = AuthorizationViewController()
            window?.rootViewController = authViewController
            window?.makeKeyAndVisible()
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
