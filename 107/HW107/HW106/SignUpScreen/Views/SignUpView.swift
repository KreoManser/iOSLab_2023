import UIKit

class SignUpView: UIView {
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up for CatGram!"
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Login"
        field.font = .systemFont(ofSize: 25)
        field.backgroundColor = UIColor(white: 0.75, alpha: 0.6)
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.indent(size: 15)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = .systemFont(ofSize: 25)
        field.backgroundColor = UIColor(white: 0.75, alpha: 0.6)
        field.isSecureTextEntry = true
        field.layer.cornerRadius = 10
        field.layer.masksToBounds = true
        field.indent(size: 15)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            guard let login = self?.loginTextField.text else { return }
            guard let password = self?.passwordTextField.text else { return }
            self?.signUpViewController?.signUpUser(login, password)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGray
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            let presentController = LoginViewController()
            presentController.modalPresentationStyle = .fullScreen
            self?.signUpViewController?.present(presentController, animated: false)
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemGray
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    weak var signUpViewController: SignUpViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(welcomeLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(signUpButton)
        addSubview(loginButton)

        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            welcomeLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            loginTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 75),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 200),
            signUpButton.widthAnchor.constraint(equalToConstant: 300),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
