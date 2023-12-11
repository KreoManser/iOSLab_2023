import UIKit

class StartScreenViewController: UIViewController {
    let startScreenView = StartScreenView()
    let authorizationController = AuthorizationViewController()
    let registrationController = RegistrationViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = startScreenView
        addTargetForButtons()
    }
    func addTargetForButtons() {
        startScreenView.authorization.addTarget(self, action: #selector(authorizationButtonTapped), for: .touchUpInside)
        startScreenView.registration.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    @objc func authorizationButtonTapped() {
        navigationController?.pushViewController(authorizationController, animated: true)
    }
    @objc func registrationButtonTapped() {
        navigationController?.pushViewController(registrationController, animated: true)
    }
}
