import UIKit
class AuthorizationView: UIView {
    lazy var label: UILabel = UILabel()
    lazy var loginTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var enterButton: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpLabel()
        setUpLoginTextField()
        setUpPasswordTextField()
        setUpEnterButton()
    }
    private func setUpLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.font = UIFont(name: "systemFont", size: 34)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200),
            label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setUpLoginTextField() {
        addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Введите почту"
        loginTextField.backgroundColor = .systemGray
        loginTextField.layer.cornerRadius = 8
        loginTextField.borderStyle = .roundedRect
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 400),
            loginTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            loginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func  setUpPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.backgroundColor = .systemGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func  setUpEnterButton() {
        addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle("Войти", for: .normal)
        enterButton.backgroundColor = .systemGray
        enterButton.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            enterButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 30),
            enterButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
