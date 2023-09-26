import UIKit

class AuthorisationViewController: UIViewController {

    lazy var authorisationImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profile")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .systemOrange
        return image
    }()

    lazy var loginLabel: UILabel = {
        let login = UILabel()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        login.text = "Логин"
        login.font = UIFont.systemFont(ofSize: 14)
        return login
    }()

    lazy var loginTextArea: UITextField = {
        var login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        
        login.font = UIFont.systemFont(ofSize: 12)
        login.backgroundColor = .systemGray4
        login.layer.cornerRadius = 5
        login.placeholder = "Логин"
        return login
    }()

    lazy var passwordLabel: UILabel = {
        let password = UILabel()
        password.translatesAutoresizingMaskIntoConstraints = false
        
        password.text = "Пароль"
        password.font = UIFont.systemFont(ofSize: 14)
        return password
    }()

    lazy var passwordTextArea: UITextField = {
        var password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        
        password.font = UIFont.systemFont(ofSize: 12)
        password.backgroundColor = .systemGray4
        password.layer.cornerRadius = 5
        password.placeholder = "Пароль"
        return password
    }()

    @objc lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        return button
    }()

    @IBAction func logInButtonAction(_ sender: Any) {

        let enteredLogin = loginTextArea.text ?? ""
        let enteredPassword = passwordTextArea.text ?? ""
        
        if isValidLogin(enteredLogin, password: enteredPassword) {
            let accountViewController = AccountViewController()
            self.navigationController?.pushViewController(accountViewController, animated: true)
        } 
        else {
            showAlert(title: "Ошибка", message: "Неверный логин или пароль")
        }
    }
    
    func isValidLogin(_ login: String, password: String) -> Bool {
        
        return login == "Admin" && password == "123"
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Sign in"
    }

    private func setupLayouts() {
        let authorisationStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextArea, passwordLabel, passwordTextArea])
        authorisationStackView.translatesAutoresizingMaskIntoConstraints = false
        authorisationStackView.spacing = 5
        authorisationStackView.axis = .vertical

        view.addSubview(authorisationImageView)
        view.addSubview(authorisationStackView)
        view.addSubview(logInButton)
        
        let screenHeight = UIScreen.main.bounds.height
        let imageHeight = screenHeight * 0.55

        NSLayoutConstraint.activate([
            authorisationImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            authorisationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            authorisationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            authorisationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            
            loginLabel.topAnchor.constraint(equalTo: authorisationImageView.bottomAnchor, constant: 20),
            
            loginTextArea.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -10),
            loginTextArea.heightAnchor.constraint(equalToConstant: 34),
            
            passwordTextArea.heightAnchor.constraint(equalToConstant: 34),

            logInButton.widthAnchor.constraint(equalToConstant: 222),
            logInButton.heightAnchor.constraint(equalToConstant: 34),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: passwordTextArea.bottomAnchor, constant: 20),
            
            authorisationStackView.widthAnchor.constraint(equalTo: authorisationImageView.widthAnchor),
            authorisationStackView.leadingAnchor.constraint(equalTo: authorisationImageView.leadingAnchor),
            authorisationStackView.trailingAnchor.constraint(equalTo: authorisationImageView.trailingAnchor),
            authorisationStackView.topAnchor.constraint(equalTo: authorisationImageView.bottomAnchor, constant: 10)
        ])
    }
}
