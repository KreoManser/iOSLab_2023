import UIKit

class ProfileViewController: UIViewController {
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "profile")
        return image
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пингвин"
        label.textColor = .black
        label.font = label.font.withSize(30)
        return label
    }()
    lazy var numberPhoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(8-800-555-3535)"
        label.textColor = .lightGray
        label.font = label.font.withSize(30)
        return label
    }()
    lazy var busketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Корзина", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(busketButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var shopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Магазин", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var salesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Скидки", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Избранное", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Оплата", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray3
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func shopButtonTapped() {
        let rootVC = ShopViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        show(navVC, sender: self)
    }
    @objc func busketButtonTapped() {
        let rootVC = BusketViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        show(navVC, sender: self)
    }
    @objc func exitButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubViews()
        allConstraints()
    }
    private func addAllSubViews(){
        view.backgroundColor = .white
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(numberPhoneLabel)
        view.addSubview(shopButton)
        view.addSubview(salesButton)
        view.addSubview(shopButton)
        view.addSubview(busketButton)
        view.addSubview(favoritesButton)
        view.addSubview(paymentButton)
        view.addSubview(exitButton)
    }
    private func allConstraints(){
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberPhoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            numberPhoneLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68),
            numberPhoneLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            numberPhoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            busketButton.topAnchor.constraint(equalTo: numberPhoneLabel.bottomAnchor, constant: 20),
            busketButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            busketButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            busketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shopButton.topAnchor.constraint(equalTo: busketButton.bottomAnchor, constant: 20),
            shopButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            shopButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            shopButton.leftAnchor.constraint(equalTo: busketButton.leftAnchor),
            
            
            salesButton.topAnchor.constraint(equalTo: busketButton.bottomAnchor, constant: 20),
            salesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            salesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            salesButton.rightAnchor.constraint(equalTo: busketButton.rightAnchor),
            
            favoritesButton.topAnchor.constraint(equalTo: salesButton.bottomAnchor, constant: 20),
            favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            favoritesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            favoritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            paymentButton.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 20),
            paymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
            paymentButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            exitButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
