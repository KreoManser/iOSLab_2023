import UIKit

class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    let dataManager = ProfileDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        setButtonAction()
    }
    func setButtonAction() {
        settingsView.setExitButtonActionClosure { [weak self] in
            let alert = UIAlertController(title: "", message: "Выйти из аккаунта?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    self?.dataManager.userDefaults.removeObject(forKey: self?.dataManager.user?.login ?? "")
                    sceneDelegate.window?.rootViewController = AuthorizationViewController()
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
