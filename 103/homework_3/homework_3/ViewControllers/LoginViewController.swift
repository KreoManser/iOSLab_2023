import UIKit

internal class LoginViewController: UIViewController, UITextFieldDelegate {

    private lazy var loginImageView: UIImageView = {
        let image = UIImageView();
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.image = UIImage(named: "shop");
        image.contentMode = .scaleAspectFit;
        
        return image;
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Логин";
        label.font = UIFont.systemFont(ofSize: 10);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField();
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.placeholder = "Логин";
        textField.font = UIFont.systemFont(ofSize: 12);
        textField.layer.cornerRadius = 5;
        textField.backgroundColor = .systemGray3;
        
        // отступ слева
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30));
        textField.leftView = leftView;
        textField.leftViewMode = .always;

        return textField;
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Пароль";
        label.font = UIFont.systemFont(ofSize: 10);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField();
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.layer.cornerRadius = 5;
        textField.placeholder = "Пароль";
        textField.font = UIFont.systemFont(ofSize: 12);
        textField.isSecureTextEntry = true;
        textField.backgroundColor = .systemGray3;
        
        // отступ слева
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30));
        textField.leftView = leftView;
        textField.leftViewMode = .always;
        
        return textField;
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Войти", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside);
        button.layer.cornerRadius = 5;
        
        return button;
    }()

    override func viewDidLoad() {
        super.viewDidLoad();
        
        addSubviews();
        setConstraint();
        
        view.backgroundColor = .white;
        
        loginTextField.delegate = self;
        passwordTextField.delegate = self;
    }
    
    private func addSubviews(){
        view.addSubview(loginImageView);
        view.addSubview(loginTextField);
        view.addSubview(loginLabel);
        view.addSubview(passwordTextField);
        view.addSubview(passwordLabel);
        view.addSubview(loginButton);
    }
    
    private func setConstraint(){
        NSLayoutConstraint.activate([
            loginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            loginImageView.widthAnchor.constraint(equalToConstant: 300),
            loginImageView.heightAnchor.constraint(equalToConstant: 300),
            loginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            loginImageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            loginImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16),
            
            loginLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -5),
            loginLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 100),
            loginTextField.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.widthAnchor.constraint(equalToConstant: 300),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -5),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ]);
    }
    
    @objc private func buttonPressed() {
        if (loginTextField.text == "Admin" && passwordTextField.text == "123"){
            loginTextField.text = "";
            passwordTextField.text = "";
            let profileViewController = ProfileViewController();
            profileViewController.modalPresentationStyle = .fullScreen;
            present(profileViewController, animated: true);
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
            alertController.addAction(okAction);
            present(alertController, animated: true);
            
            loginTextField.text = "";
            passwordTextField.text = "";
        }
    }
}


