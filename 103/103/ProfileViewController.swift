import UIKit

class ProfileViewController: UIViewController {
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "dog")
        return image
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "dant tnad"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var telephoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 999 999 3301"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var nameAndNumberSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel, telephoneNumberLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    
    lazy var binButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Корзина", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(openBinPage), for: .touchUpInside)
        return button
    }()
    
    lazy var firstUselessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("Магазин", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(openStore), for: .touchUpInside)
        return button
    }()
    
    lazy var secondUselessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("Что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    lazy var thirthUselessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("Что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    lazy var fourthUselessButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("Что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    lazy var twoUselessHorizontalButtonsSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstUselessButton, secondUselessButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var twoUselessVerticalButtonsSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirthUselessButton, fourthUselessButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(returnBackToLogInScreen), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubViews()
        
        setUpConstraints()
    }
    
        func addSubViews() {
            view.addSubview(avatarImageView)
            view.addSubview(nameAndNumberSV)
            view.addSubview(binButton)
            view.addSubview(twoUselessHorizontalButtonsSV)
            view.addSubview(twoUselessVerticalButtonsSV)
            view.addSubview(logOutButton)
  }
    
    @objc func returnBackToLogInScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func openBinPage() {
        navigationController?.pushViewController(BinViewController(), animated: true)
    }
    
    @objc func openStore() {
        navigationController?.pushViewController(StoreViewController(), animated: true)
    }
    

}

extension ProfileViewController {
    
    func setUpConstraints() {
        setUpAvatarConstraints()
        setUpNameAndNumberSVConstraints()
        setUpBinButtonConstraints()
        setUpHorizontalUselessButtonsSVConstraints()
        setUpVerticalUselessButtonsSVConstraints()
        setUpLogOutButtonConstraints()
    }
    
    func setUpAvatarConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        ])
    }
    
    func setUpNameAndNumberSVConstraints() {
        NSLayoutConstraint.activate([
            nameAndNumberSV.widthAnchor.constraint(equalToConstant: 200),
            nameAndNumberSV.heightAnchor.constraint(equalToConstant: 60),
            nameAndNumberSV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameAndNumberSV.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
        ])
    }
    
    func setUpBinButtonConstraints() {
        NSLayoutConstraint.activate([
            binButton.topAnchor.constraint(equalTo: nameAndNumberSV.bottomAnchor, constant: 20),
            binButton.widthAnchor.constraint(equalToConstant: 220),
            binButton.heightAnchor.constraint(equalToConstant: 40),
            binButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setUpHorizontalUselessButtonsSVConstraints() {
        NSLayoutConstraint.activate([
            twoUselessHorizontalButtonsSV.topAnchor.constraint(equalTo: binButton.bottomAnchor, constant: 20),
            twoUselessHorizontalButtonsSV.widthAnchor.constraint(equalToConstant: 220),
            twoUselessHorizontalButtonsSV.heightAnchor.constraint(equalToConstant: 40),
            twoUselessHorizontalButtonsSV.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setUpVerticalUselessButtonsSVConstraints() {
        NSLayoutConstraint.activate([
            twoUselessVerticalButtonsSV.topAnchor.constraint(equalTo: twoUselessHorizontalButtonsSV.bottomAnchor, constant: 20),
            twoUselessVerticalButtonsSV.widthAnchor.constraint(equalToConstant: 120),
            twoUselessVerticalButtonsSV.heightAnchor.constraint(equalToConstant: 90),
            twoUselessVerticalButtonsSV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setUpLogOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 220),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
    }
}
