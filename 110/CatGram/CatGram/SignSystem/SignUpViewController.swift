import UIKit

protocol ReloadArraySignUpDelegate: AnyObject {
    func reloadArrayAfterAddingNewUser(_ sugnUpVC: SignUpViewController, user: User)
}

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var users = [User] ()
    let dataManager = DataManager()
    let coreDataManager = CoreDataManager.shared

    weak var delegate: ReloadArraySignUpDelegate?

    var OKButton: UIButton = {
        let button = UIButton()
        button.setTitle("ok", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var loginText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Create a login:"
        return text
    }()
    var passwordText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Create a password:"
        return text
    }()
    var loginTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.borderStyle = .line
        return login
    }()
    var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.borderStyle = .line
        password.isSecureTextEntry = true
        return password
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        users = dataManager.getUsers()

        view.backgroundColor = .white

        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        OKButton.addTarget(self, action: #selector(pushToProfile), for: .touchUpInside)

        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginText)
        view.addSubview(passwordText)
        view.addSubview(OKButton)

        let textHeight: CGFloat = 30.0
        let textdWidth: CGFloat = 300.0
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            // Ограничения для loginText
            loginText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            loginText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginText.widthAnchor.constraint(equalToConstant: textdWidth),
            loginText.heightAnchor.constraint(equalToConstant: textHeight),

            // Ограничения для loginTextField
            loginTextField.topAnchor.constraint(equalTo: loginText.bottomAnchor, constant: 10),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: textdWidth),
            loginTextField.heightAnchor.constraint(equalToConstant: textHeight),

            // Ограничения для passwordText
            passwordText.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordText.widthAnchor.constraint(equalToConstant: textdWidth),
            passwordText.heightAnchor.constraint(equalToConstant: textHeight),

            // Ограничения для passwordTextField
            passwordTextField.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: textdWidth),
            passwordTextField.heightAnchor.constraint(equalToConstant: textHeight),

            // Ограничения для OKButton
            OKButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            OKButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            OKButton.widthAnchor.constraint(equalToConstant: 100.0),
            OKButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }

    @objc func pushToProfile() {
        users = dataManager.getUsers()
        if let user = users.first(where: { $0.login == loginTextField.text }) {
            print("User with the login '\(String(describing: user.login))' already exists")
            return
        }
        if let login = loginTextField.text, let password = passwordTextField.text {
            if let avaImage = UIImage(named: "no-avatar") {
                let newUser = coreDataManager.createUser(login: login, password: password, username: login, avatar: avaImage, description: " ")

                coreDataManager.saveContext()
                self.delegate?.reloadArrayAfterAddingNewUser(self, user: newUser)

//                dataManager.addNewUser(user: newUser)
                print("users of data manager from sign up: \(dataManager.getUsers())")
                
                dataManager.loginDefaults()
                dataManager.saveUserByLogin(newUser)

                let tabBarController = UITabBarController()

                let feedViewController = FeedViewController()
                let feedNavigationController = UINavigationController(rootViewController: feedViewController)
                feedViewController.user = newUser
                feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: nil, tag: 0)

                let profileViewController = ProfileViewController()
                let profileNavigationController = UINavigationController(rootViewController: profileViewController)
                profileViewController.user = newUser
                profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 1)

                tabBarController.viewControllers = [feedNavigationController, profileNavigationController]

                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = tabBarController
                }
            }
        }
    }
}

