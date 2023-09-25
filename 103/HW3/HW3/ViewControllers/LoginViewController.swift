import UIKit

class LoginViewController: UIViewController {    
    lazy var loginUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    lazy var loginUILabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordUILabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }

    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(loginUIImageView)
        view.addSubview(loginUILabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordUILabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginUIImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            loginUIImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginUIImageView.heightAnchor.constraint(equalToConstant: 200),
            loginUIImageView.widthAnchor.constraint(equalToConstant: 200),
            
            loginUILabel.topAnchor.constraint(equalTo: loginUIImageView.bottomAnchor, constant: 50),
            loginUILabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginUILabel.heightAnchor.constraint(equalToConstant: 25),
            loginUILabel.widthAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: loginUILabel.bottomAnchor, constant: 10),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            passwordUILabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordUILabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordUILabel.heightAnchor.constraint(equalToConstant: 25),
            passwordUILabel.widthAnchor.constraint(equalToConstant: 100),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordUILabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            loginButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func handleLogin() {
        if loginTextField.text == "Admin" && passwordTextField.text == "123" {
            let profileViewController = ProfileViewController()
            profileViewController.modalPresentationStyle = .fullScreen
            self.present(profileViewController, animated: true, completion: nil)
        }
    }
}
