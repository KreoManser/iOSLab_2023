import Foundation
import UIKit

class ViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(systemName: "person")
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .roundedRect
        loginTextField.placeholder = "Login"
        return loginTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "LOGIN"
        config.baseForegroundColor = .blue

        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.loginButtonTapped()
            })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(profileImageView, loginTextField, passwordTextField, loginButton)
        configureUI()
    }
    
    private func loginButtonTapped(){
        let loginVC = ProfileViewController()
        guard loginTextField.text ==  "Admin" else{ return }
        guard passwordTextField.text ==  "123" else{ return }
        
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

extension ViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func configureUI() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileImageView.heightAnchor.constraint(equalToConstant: 250),
            
            loginTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            
            
        ])
    }
}



