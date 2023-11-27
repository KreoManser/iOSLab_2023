import UIKit

class SettingsViewController: UIViewController {
    private let settingsView = SettingsView(frame: .zero)
    private let dataManager = DataManager.shared

    override func loadView() {
        view = settingsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.settingsViewController = self
    }
}

extension SettingsViewController {
    func logOutUser() {
        dataManager.logOutUser()
        let presentContoller = LoginViewController()
        presentContoller.modalPresentationStyle = .fullScreen
        present(presentContoller, animated: true)
    }
}
