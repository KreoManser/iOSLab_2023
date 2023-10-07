import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(systemName: "person")
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 129
        return profileImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Name"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let view = UILabel()
        view.text = "Number"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shopButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Shop"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.shopButtonTapped()
            })
    }()
    
    private lazy var BasketButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Basket"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.basketButtonTapped()
            })
    }()
    
    private lazy var exitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Exit"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
                self?.exitButtonTapped()
            })
    }()
    
    private lazy var additionButton1: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "chto-to"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
            })
    }()
    
    private lazy var additionButton2: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "chto-to"
        config.baseForegroundColor = .blue
        
        return UIButton(
            configuration: config,
            primaryAction: UIAction { [weak self] _ in
            })
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(profileImageView, nameLabel, numberLabel, BasketButton, exitButton,shopButton, additionButton1, additionButton2)
        configureUI()
        
    }
    
    
    private func shopButtonTapped(){
        let nextVC = ShopViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func basketButtonTapped(){
        let nextVC = BasketViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func exitButtonTapped(){
        let nextVC = ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ProfileViewController{
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func configureUI(){
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        BasketButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        additionButton1.translatesAutoresizingMaskIntoConstraints = false
        additionButton2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        profileImageView.heightAnchor.constraint(equalToConstant: 250),
        
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
        numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        numberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        BasketButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 20),
        BasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        BasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        
        additionButton1.topAnchor.constraint(equalTo: BasketButton.bottomAnchor, constant: 20),
        additionButton1.leadingAnchor.constraint(equalTo: BasketButton.leadingAnchor),
        additionButton1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
        
        additionButton2.topAnchor.constraint(equalTo: BasketButton.bottomAnchor, constant: 20),
        additionButton2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
        additionButton2.trailingAnchor.constraint(equalTo: BasketButton.trailingAnchor),
        
        shopButton.topAnchor.constraint(equalTo: additionButton1.bottomAnchor, constant: 20),
        shopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        shopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        
        exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
        exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        ])
    }
}
