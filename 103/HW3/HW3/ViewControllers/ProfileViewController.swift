import UIKit

class ProfileViewController: UIViewController {
    private let name = "Тимур Хайруллин"
    private let phoneNumber = "8 800 555 3535"
    private let profileImagesize = 170.0
    lazy var profileUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        print(imageView.frame.width)
        imageView.layer.cornerRadius = profileImagesize/2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameUILabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var phoneUILabel: UILabel = {
        let label = UILabel()
        label.text = phoneNumber
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Exit", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var marketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Market", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleMarket), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var basketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Basket", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleBasket), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-----", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-----", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var thirdButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("|", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var fourthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("|", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(profileUIImageView)
        view.addSubview(nameUILabel)
        view.addSubview(phoneUILabel)
        view.addSubview(basketButton)
        view.addSubview(marketButton)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        view.addSubview(fourthButton)
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            profileUIImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            profileUIImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileUIImageView.heightAnchor.constraint(equalToConstant: profileImagesize),
            profileUIImageView.widthAnchor.constraint(equalToConstant: profileImagesize),
            
            nameUILabel.topAnchor.constraint(equalTo: profileUIImageView.bottomAnchor, constant: 10),
            nameUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameUILabel.heightAnchor.constraint(equalToConstant: 30),
            nameUILabel.widthAnchor.constraint(equalToConstant: 300),
            
            phoneUILabel.topAnchor.constraint(equalTo: nameUILabel.bottomAnchor),
            phoneUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneUILabel.heightAnchor.constraint(equalToConstant: 30),
            phoneUILabel.widthAnchor.constraint(equalToConstant: 300),
            
            basketButton.topAnchor.constraint(equalTo: phoneUILabel.bottomAnchor, constant: 20),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 205),
            basketButton.heightAnchor.constraint(equalToConstant: 35),
            
            marketButton.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 5),
            marketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            marketButton.widthAnchor.constraint(equalToConstant: 205),
            marketButton.heightAnchor.constraint(equalToConstant: 35),
            
            firstButton.topAnchor.constraint(equalTo: marketButton.bottomAnchor, constant: 5),
            firstButton.leadingAnchor.constraint(equalTo: marketButton.leadingAnchor),
            firstButton.heightAnchor.constraint(equalToConstant: 35),
            firstButton.widthAnchor.constraint(equalToConstant: 100),
            
            secondButton.topAnchor.constraint(equalTo: marketButton.bottomAnchor, constant: 5),
            secondButton.leadingAnchor.constraint(equalTo: firstButton.trailingAnchor, constant: 5),
            secondButton.heightAnchor.constraint(equalToConstant: 35),
            secondButton.widthAnchor.constraint(equalToConstant: 100),
            
            thirdButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 5),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.heightAnchor.constraint(equalToConstant: 35),
            thirdButton.widthAnchor.constraint(equalToConstant: 100),
            
            fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor, constant: 5),
            fourthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthButton.heightAnchor.constraint(equalToConstant: 35),
            fourthButton.widthAnchor.constraint(equalToConstant: 100),
            
            exitButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 35),
            exitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func handleExit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleBasket() {
        let basketViewController = BasketViewController()
        basketViewController.modalPresentationStyle = .fullScreen
        self.present(basketViewController, animated: true, completion: nil)
    }
    
    @objc func handleMarket() {
        let marketViewController = MarketViewController()
        marketViewController.modalPresentationStyle = .fullScreen
        self.present(marketViewController, animated: true, completion: nil)
    }
}
