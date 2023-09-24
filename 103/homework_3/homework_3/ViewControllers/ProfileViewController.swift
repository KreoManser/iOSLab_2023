import UIKit

internal class ProfileViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView();
        image.image = UIImage(named: "user");
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.contentMode = .scaleAspectFit;
        image.frame = CGRectMake(0, 0, 200, 200);
        image.layer.borderColor = UIColor.systemGray3.cgColor;
        image.layer.borderWidth = 1;
        
        return image;
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .black;
        label.font = label.font.withSize(25);
        label.text = "Данил";
        
        return label;
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .lightGray;
        label.font = label.font.withSize(20);
        label.text = "8 855 262 4731";
        
        return label;
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Корзина", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        button.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside);
        
        return button;
    }()
    
    private lazy var leftButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Что-то", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        
        return button;
    }()
    
    private lazy var rightButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Что-то", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        
        return button;
    }()
    
    private lazy var bottomButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Что-то", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        
        return button;
    }()
    
    private lazy var shopButton = {
        let button = UIButton();
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Магазин", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        button.addTarget(self, action: #selector(shopButtonPressed), for: .touchUpInside);
        
        return button;
    }()
    
    private lazy var exitButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Выйти", for: .normal);
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12);
        button.setTitleColor(.black, for: .normal);
        button.backgroundColor = .systemGray3;
        button.layer.cornerRadius = 5;
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside);
        
        return button;
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white;
        super.viewDidLoad();
        avatarImageView.layer.masksToBounds = true;
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2;
        
        addSubviews();
        setConstraints();
    }
    
    private func addSubviews(){
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(bottomButton)
        view.addSubview(shopButton)
        view.addSubview(exitButton)
        view.addSubview(cartButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 15),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cartButton.widthAnchor.constraint(equalToConstant: 200),
            cartButton.heightAnchor.constraint(equalToConstant: 30),
            cartButton.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            cartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftButton.widthAnchor.constraint(equalToConstant: 90),
            leftButton.heightAnchor.constraint(equalToConstant: 30),
            leftButton.topAnchor.constraint(equalTo: cartButton.bottomAnchor, constant: 15),
            leftButton.leadingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: 0),
            
            rightButton.widthAnchor.constraint(equalToConstant: 90),
            rightButton.heightAnchor.constraint(equalToConstant: 30),
            rightButton.topAnchor.constraint(equalTo: cartButton.bottomAnchor, constant: 15),
            rightButton.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 0),
            
            shopButton.widthAnchor.constraint(equalToConstant: 90),
            shopButton.heightAnchor.constraint(equalToConstant: 30),
            shopButton.topAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: 15),
            shopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomButton.widthAnchor.constraint(equalToConstant: 90),
            bottomButton.heightAnchor.constraint(equalToConstant: 30),
            bottomButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: 15),
            bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 200),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.topAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: 200),
        ])
    }

    
    
    @objc private func cartButtonPressed() {
        let cartViewController = CartViewController();
        cartViewController.modalPresentationStyle = .fullScreen;
        present(cartViewController, animated: true);
    }
    
    @objc private func shopButtonPressed() {
        let shopViewController = ShopViewController();
        shopViewController.modalPresentationStyle = .fullScreen;
        present(shopViewController, animated: true);
    }
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true)
    }
}

