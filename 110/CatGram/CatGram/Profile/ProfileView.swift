//
//  UIProfileView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.10.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func goToSettingsController()
    func goToFollowerController()
    func addPublication()
}

class ProfileView: UIView {

    weak var delegate: ProfileViewDelegate?

    lazy var buttonName: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Славный_Котик", style: .done, target: nil, action: nil)
        button.tintColor = .black
        return button
    }()

    lazy var addPublication: UIBarButtonItem = {
        let action = UIAction { _ in self.delegate?.addPublication() }
        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        button.tintColor = .black
        return button
    }()

    lazy var settingsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.settings
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return image
    }()

    lazy var buttonSettings: UIBarButtonItem = {
        let action = UIAction { _ in
            self.delegate?.goToSettingsController()
        }
        let button = UIBarButtonItem(image: settingsImage.image, primaryAction: action)
        button.tintColor = .black
        return button
    }()

    lazy var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "kot3")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 40
        avatar.layer.masksToBounds = true
        return avatar
    }()

    lazy var stackView: UIStackView = {
        let numberStackView = UIStackView()
        numberStackView.translatesAutoresizingMaskIntoConstraints = false
        numberStackView.axis = .horizontal
        numberStackView.spacing = 8
        return numberStackView
    }()

    // Публикации
    lazy var buttonNumberPublication: UIButton = {
        let button = UIButton()
        button.setTitle("20\nПубликаций", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Подписки
    lazy var buttonSubscriptions: UIButton = {
        let button = UIButton()
        button.setTitle("10\nПодписок", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Подписчики
    lazy var buttonFollowers: UIButton = {
        let button = UIButton()
        button.setTitle("54\nПодписчиков", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let action = UIAction { _ in
            self.delegate?.goToFollowerController()
        }
        button.addAction(action, for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // кнопки
    lazy var toChangeProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.gray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var toShareProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Поделиться профилем", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.gray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var toInteresingCatsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "people"), for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var stackViewForButton: UIStackView = {
        let stackViewForButton = UIStackView()
        stackViewForButton.translatesAutoresizingMaskIntoConstraints = false
        stackViewForButton.axis = .horizontal
        stackViewForButton.spacing = 5
        return stackViewForButton
    }()

    init(frame: CGRect, avatarImage: UIImage, userName: String) {
        super.init(frame: frame)
        backgroundColor = .white
        self.avatarImage.image = avatarImage
        buttonName.title = userName
        setupLayout()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(avatarImage)
        stackView.addArrangedSubview(buttonNumberPublication)
        stackView.addArrangedSubview(buttonFollowers)
        stackView.addArrangedSubview(buttonSubscriptions)
        addSubview(stackView)
        stackViewForButton.addArrangedSubview(toChangeProfileButton)
        stackViewForButton.addArrangedSubview(toShareProfileButton)
        stackViewForButton.addArrangedSubview(toInteresingCatsButton)
        addSubview(stackViewForButton)
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),

            stackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 30),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 35),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackViewForButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            stackViewForButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            toInteresingCatsButton.widthAnchor.constraint(equalToConstant: 30),

            toShareProfileButton.widthAnchor.constraint(equalToConstant: 155),
            toShareProfileButton.heightAnchor.constraint(equalToConstant: 30),
            toChangeProfileButton.widthAnchor.constraint(equalToConstant: 155),
            toChangeProfileButton.heightAnchor.constraint(equalToConstant: 30)])
    }

    var collectionView: UICollectionView!

    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackViewForButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        return layout
    }
}
