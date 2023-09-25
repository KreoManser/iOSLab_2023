import UIKit

class ViewController: UIViewController {
    

    lazy var logInImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "welcome")
        return image
    }()
    lazy var logInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.text = "Логин"
        return label
    }()
    lazy var loginTextView: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.backgroundColor = .systemGray4
        login.layer.cornerRadius = 8
        return login
    }()
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.text = "Пароль"
        return label
    }()
    lazy var passwordTextView: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.isSecureTextEntry = true
        password.backgroundColor = .systemGray4
        password.layer.cornerRadius = 8
        return password
    }()

    lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    @objc func buttonTapped() {
        if loginTextView.text == "Admin", passwordTextView.text == "123"{
            let rootVC = ProfileViewController()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            show(navVC, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAllSubViews()
        allConstraints()   
    }
    private func addAllSubViews(){
        view.addSubview(logInImageView)
        view.addSubview(logInLabel)
        view.addSubview(loginTextView)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextView)
        view.addSubview(logInButton)
        
    }
    private func allConstraints(){
        NSLayoutConstraint.activate([
            logInImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            logInImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            logInImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            logInLabel.topAnchor.constraint(equalTo: logInImageView.bottomAnchor),
            logInLabel.widthAnchor.constraint(equalTo: logInImageView.widthAnchor, multiplier: 0.2),
            logInLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),
            logInLabel.leftAnchor.constraint(equalTo: logInImageView.leftAnchor),
            
            loginTextView.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 10),
            loginTextView.widthAnchor.constraint(equalTo: logInImageView.widthAnchor),
            loginTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            loginTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            passwordLabel.topAnchor.constraint(equalTo: loginTextView.bottomAnchor, constant: 20),
            passwordLabel.widthAnchor.constraint(equalTo: logInImageView.widthAnchor, multiplier: 0.2),
            passwordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.02),
            passwordLabel.leftAnchor.constraint(equalTo: logInImageView.leftAnchor),
            
            passwordTextView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextView.widthAnchor.constraint(equalTo: loginTextView.widthAnchor),
            passwordTextView.heightAnchor.constraint(equalTo: loginTextView.heightAnchor),
            passwordTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 48),
            logInButton.widthAnchor.constraint(equalToConstant: 233),
            logInButton.heightAnchor.constraint(equalTo: passwordTextView.heightAnchor),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

