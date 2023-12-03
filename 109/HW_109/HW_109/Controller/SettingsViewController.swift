import UIKit
class SettingsViewController: UIViewController {
    let settingsView = SettingsView()
    let dataManager = SettingsDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
        setButtonAction()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func setUpSettings() {
        view = settingsView
        settingsView.table.delegate = dataManager
        settingsView.table.dataSource = dataManager
        settingsView.table.register( SettingsTableViewCell.self,
                                forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
    }
    func setButtonAction() {
        dataManager.setExitButtonActionClosure { [weak self] in
            let alert = UIAlertController(title: "", message: "Выйти из аккаунта?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    self?.dataManager.actionsAfterUserExitFromAccount()
                    sceneDelegate.window?.rootViewController = AuthorizationViewController()
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
