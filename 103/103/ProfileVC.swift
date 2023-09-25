import UIKit

class ProfileViewController: UIViewController {
    
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "appleLogo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "NICK NAME"
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
        button.setTitle("Что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
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
            super.viewWillAppear(true)
            avatarImageView.image =  UIImage(named: "appleLogo")
            self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
            self.avatarImageView.clipsToBounds = true
                }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubViews()
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        setUpAvatarConstraints()
        setUpNameAndNumberSVConstraints()
        setUpBinButtonConstraints()
        setUpHorizontalUselessButtonsSVConstraints()
        setUpVericalUselessButtonsSVConstraints()
        setUpLogOutButtonConstraints()
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
    
    func setUpAvatarConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            avatarImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -550)
        ])
    }
    
    func setUpNameAndNumberSVConstraints() {
        NSLayoutConstraint.activate([
            nameAndNumberSV.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30),
            nameAndNumberSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameAndNumberSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameAndNumberSV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -470)
        ])
    }
    
    func setUpBinButtonConstraints() {
        NSLayoutConstraint.activate([
            binButton.topAnchor.constraint(equalTo: nameAndNumberSV.bottomAnchor, constant: 30),
            binButton.leadingAnchor.constraint(equalTo: nameAndNumberSV.leadingAnchor),
            binButton.trailingAnchor.constraint(equalTo: nameAndNumberSV.trailingAnchor),
            binButton.bottomAnchor.constraint(equalTo: nameAndNumberSV.bottomAnchor, constant: 70)
        ])
    }
    
    func setUpHorizontalUselessButtonsSVConstraints() {
        NSLayoutConstraint.activate([
            twoUselessHorizontalButtonsSV.topAnchor.constraint(equalTo: binButton.bottomAnchor, constant: 20),
            twoUselessHorizontalButtonsSV.leadingAnchor.constraint(equalTo: binButton.leadingAnchor),
            twoUselessHorizontalButtonsSV.trailingAnchor.constraint(equalTo: binButton.trailingAnchor),
            twoUselessHorizontalButtonsSV.bottomAnchor.constraint(equalTo: binButton.bottomAnchor, constant: 60)
        ])
    }
    
    func setUpVericalUselessButtonsSVConstraints() {
        NSLayoutConstraint.activate([
            twoUselessVerticalButtonsSV.topAnchor.constraint(equalTo: twoUselessHorizontalButtonsSV.bottomAnchor, constant: 20),
            twoUselessVerticalButtonsSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            twoUselessVerticalButtonsSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110),
            twoUselessVerticalButtonsSV.bottomAnchor.constraint(equalTo: twoUselessHorizontalButtonsSV.bottomAnchor, constant: 110)
        ])
    }
    
    func setUpLogOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: twoUselessVerticalButtonsSV.bottomAnchor, constant: 130),
            logOutButton.leadingAnchor.constraint(equalTo: twoUselessHorizontalButtonsSV.leadingAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: twoUselessHorizontalButtonsSV.trailingAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
}
