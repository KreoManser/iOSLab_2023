import UIKit

class LoginView: UIView {
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to CatGram!"
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Login"
        field.font = .systemFont(ofSize: 25)
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = .systemFont(ofSize: 25)
        field.isSecureTextEntry = true
        field.layer.cornerRadius = 10
        field.clipsToBounds = true
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var loginButtonTapped: ((_ login: String, _ password: String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    func setupLayouts() {
        addSubview(welcomeLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(logInButton)
        addSubview(signUpButton)

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

            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 200),
            logInButton.widthAnchor.constraint(equalToConstant: 300),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10),
            signUpButton.widthAnchor.constraint(equalToConstant: 300),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    func setupActions() {
        let loginAction = UIAction(handler: { [weak self] _ in
            self?.loginButtonTapped?(self?.loginTextField.text ?? "", self?.passwordTextField.text ?? "")
            self?.passwordTextField.text = ""
            self?.loginTextField.text = ""
        })
        logInButton.addAction(loginAction, for: .touchUpInside)
    }
}
