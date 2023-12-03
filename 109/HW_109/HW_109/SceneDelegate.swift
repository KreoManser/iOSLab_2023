import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let authorizationViewController = AuthorizationViewController()
            if UserDefaults.standard.bool(forKey: "user") {
                do {
                    DataSource.shared.addUsers()
                    let decoder = JSONDecoder()
                    guard let encodedUser = UserDefaults.standard.data(forKey: "userData") else { return }
                    let user = try decoder.decode(User.self, from: encodedUser)
                    window?.rootViewController = UINavigationController(rootViewController: authorizationViewController)
                    authorizationViewController.setUpTabBar(user: user)
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                }
            } else {
                let navigationController = UINavigationController(rootViewController: authorizationViewController)
                navigationController.isNavigationBarHidden = true
                self.window = UIWindow(windowScene: windowScene)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its sessi
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        ProfileDataManager.shared.setLikedPhotosInUserDefaults()
    }
}
