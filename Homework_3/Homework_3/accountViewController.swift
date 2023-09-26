import UIKit

class AccountViewController: UIViewController {

    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 100
        image.backgroundColor = .darkGray
        return image
    }()

    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.text = "Имя"
        name.font = UIFont.systemFont(ofSize: 30)
        return name
    }()

    lazy var numberLabel: UILabel = {
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        
        number.text = "8 800 555 35-35"
        number.font = UIFont.systemFont(ofSize: 30)
        number.textColor = UIColor.darkGray
        return number
    }()

    lazy var bucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Корзина", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(bucketButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var somethingFirstButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var somethingSecondButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var somethingThirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var somethingFourthButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Что-то", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()

    @objc lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.darkText, for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 5

        button.addTarget(self, action: #selector(exitButton), for: .touchUpInside)
        return button
    }()

    @objc func exitButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func bucketButtonAction() {
            let bucketViewController = BucketViewController()
            navigationController?.pushViewController(bucketViewController, animated: true)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupLayouts() {
        let horizontalButtonsStackView = UIStackView(arrangedSubviews: [somethingFirstButton, somethingSecondButton])
        let verticalButtonsStackView = UIStackView(arrangedSubviews: [somethingThirdButton, somethingFourthButton])
        horizontalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStackView.spacing = 23
        verticalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false

        verticalButtonsStackView.spacing = 10
        verticalButtonsStackView.axis = .vertical
        horizontalButtonsStackView.axis = .horizontal

        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(bucketButton)
        view.addSubview(horizontalButtonsStackView)
        view.addSubview(verticalButtonsStackView)
        view.addSubview(logOutButton)

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bucketButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 15),
            bucketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bucketButton.widthAnchor.constraint(equalToConstant: 223),
            bucketButton.heightAnchor.constraint(equalToConstant: 34),
            
            somethingFirstButton.widthAnchor.constraint(equalToConstant: 100),
            somethingSecondButton.widthAnchor.constraint(equalToConstant: 100),
            somethingThirdButton.widthAnchor.constraint(equalToConstant: 100),
            somethingFourthButton.widthAnchor.constraint(equalToConstant: 100),

            logOutButton.widthAnchor.constraint(equalToConstant: 222),
            logOutButton.heightAnchor.constraint(equalToConstant: 34),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            horizontalButtonsStackView.topAnchor.constraint(equalTo: bucketButton.bottomAnchor, constant: 10),
            horizontalButtonsStackView.heightAnchor.constraint(equalToConstant: 27),
            horizontalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            verticalButtonsStackView.topAnchor.constraint(equalTo: horizontalButtonsStackView.bottomAnchor, constant: 10),
            verticalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
