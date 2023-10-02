import UIKit

class ViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "pizza0")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.0
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .scaleAspectFit
        stackView.axis = .vertical
        return stackView
        
    }()
    
    private lazy var loginLabelView: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = UIFont.boldSystemFont(ofSize: 12.0)
        labelView.text = "Логин"
        labelView.textColor = .black
        return labelView
    }()
    
    private lazy var loginTextFieldView: UITextField = {
        let textFieldView = UITextField()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.placeholder = "Логин"
        textFieldView.borderStyle = .roundedRect
        textFieldView.layer.cornerRadius = 10.0
        textFieldView.clipsToBounds = true
        textFieldView.font = UIFont.boldSystemFont(ofSize: 12.0)
        textFieldView.backgroundColor = .systemGray4
        return textFieldView
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .scaleAspectFit
        stackView.axis = .vertical
        return stackView
        
    }()
    private lazy var passwordLabelView: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = UIFont.boldSystemFont(ofSize: 12.0)
        labelView.text = "Пароль"
        labelView.textColor = .black
        return labelView
    }()
    
    private lazy var passwordTextFieldView: UITextField = {
        let textFieldView = UITextField()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.placeholder = "Пароль"
        textFieldView.borderStyle = .roundedRect
        textFieldView.layer.cornerRadius = 10.0
        textFieldView.clipsToBounds = true
        textFieldView.font = UIFont.boldSystemFont(ofSize: 12.0)
        textFieldView.backgroundColor = .systemGray4
        return textFieldView
    }()
    
    private lazy var buttonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10.0
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.addTarget(self, action: #selector(login), for: .touchDown)
        
        return button
        
    }()
    
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
    
    @objc private func login(){
//        guard  loginTextFieldView.text == "Admin", passwordTextFieldView.text == "123" else {return}
        let profileController = ProfileViewController()
        self.navigationController?.pushViewController(profileController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        loginStackView.addArrangedSubview(loginLabelView)
        loginStackView.addArrangedSubview(loginTextFieldView)
        view.addSubview(loginStackView)
//        
        passwordStackView.addArrangedSubview(passwordLabelView)
        passwordStackView.addArrangedSubview(passwordTextFieldView)
        view.addSubview(passwordStackView)
        
        view.addSubview(buttonView)
        
//        scrollView.addSubview(imageView)
//        scrollView.addSubview(loginStackView)
//        scrollView.addSubview(passwordStackView)
//        scrollView.addSubview(buttonView)
//        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //            stackView login
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // stackView login
            loginStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            //            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31.0),
            //            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31.0),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.widthAnchor.constraint(equalToConstant: 328),
            
            // stackView password
            passwordStackView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 5),
            passwordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordStackView.widthAnchor.constraint(equalToConstant: 328),
            
            // buttonView
            //            buttonView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 16.0),
            //            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31.0),
            //            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31.0),
            buttonView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 5),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: 223),
        ])
    }
}
