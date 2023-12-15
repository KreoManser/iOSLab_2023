import UIKit

class SignUpViewController: UIViewController {
    private lazy var signUpView = SignUpView(frame: .zero)

    override func loadView() {
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.signUpViewController = self
    }
}

extension SignUpViewController {
    func signUpUser(_ login: String, _ password: String) {
        if login.contains(" ") || password.contains(" ") || login.isEmpty || password.isEmpty {
            signUpView.passwordTextField.text = ""
            signUpView.loginTextField.text = ""
            let alert = UIAlertController(title: "Error",
            message: "Please check input login and password. Try again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        } else {
            CoreDataManager.shared.createUser(login: login, password: password)
            let presentController = LoginViewController()
            presentController.modalPresentationStyle = .fullScreen
            present(presentController, animated: false)
        }
    }
}
