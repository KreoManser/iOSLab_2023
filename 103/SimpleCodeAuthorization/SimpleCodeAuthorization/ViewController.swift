import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var OKButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .systemBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mainCat")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 125.0
        image.clipsToBounds = true
        return image
    }()
    var loginText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Login:"
        return text
    }()
    var passwordText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Password:"
        return text
    }()
    var loginTextField: UITextField = {
        let login = UITextField ()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.borderStyle = .line
        return login
    }()
    var passwordTextField: UITextField = {
        let password = UITextField ()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.borderStyle = .line
        password.isSecureTextEntry = true
        return password
    }()
    
    let correctLogin = "Admin"
    let correctPassword = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        OKButton.addTarget(self, action: #selector(pushToProfile), for: .touchUpInside)

        view.addSubview(imageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginText)
        view.addSubview(passwordText)
        view.addSubview(OKButton)

        let textHeight: CGFloat = 30.0
        let textdWidth: CGFloat = 300.0
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // Ограничения для imageView
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250.0),
            imageView.heightAnchor.constraint(equalToConstant: 250.0),
            
            // Ограничения для loginText
            loginText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
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
        if (loginTextField.text == correctLogin) && (passwordTextField.text == correctPassword) {
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }

}
