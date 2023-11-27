//
//  ProfileView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 01.11.2023.
//

import UIKit

class ProfileView: UIView {
    weak var controller: ProfileViewController?
    var cat: User? {
        didSet {
            avatarImage.image = UIImage(data: cat?.imageAvatarData ?? Data())
            descriptionCanal.text = cat?.description
        }
    }
    var count: Int = 0 {
        didSet {
            self.numberPublication.text = "\(self.count)"
        }
    }
    lazy var buttonForRefactorProfile: UIButton = {
        var action = UIAction { _ in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Выйти", style: .destructive) { _ in
                UserDefaults.standard.setValue(false, forKey: "loggedIn")
                SceneDelegate.window?.rootViewController = RegistrationViewController()
                SceneDelegate.window?.makeKeyAndVisible()
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.controller?.present(alertController, animated: true, completion: nil)
        }
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "threePoints")
        button.setImage(buttonImage, for: .normal)
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(data: controller?.currentCat?.imageAvatarData ?? Data())
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var textPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Publication"
        return text
    }()
    lazy var numberPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "\(count)"
        return text
    }()
    lazy var textSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Subscribers"
        return text
    }()
    lazy var numberSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "1000000"
        return text
    }()
    lazy var textSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Subscriptions"
        return text
    }()
    lazy var numberSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "200"
        return text
    }()
    lazy var descriptionCanal: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .white
        return text
    }()
    lazy var gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width) / 3, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            GridCollectionViewCell.self,
            forCellWithReuseIdentifier: GridCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        addSubview(avatarImage)
        addSubview(descriptionCanal)
        addSubview(gridCollectionView)
        setupNavigationBar()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let mainStackView1 = createVerticalStackView([textPublication, numberPublication])
        let mainStacklView2 = createVerticalStackView([textSubscribers, numberSubscribers])
        let mainStacklView3 = createVerticalStackView([textSubscriptions, numberSubscriptions])
        addSubview(mainStackView1)
        addSubview(mainStacklView2)
        addSubview(mainStacklView3)
            NSLayoutConstraint.activate([
                avatarImage.widthAnchor.constraint(equalToConstant: 80),
                avatarImage.heightAnchor.constraint(equalToConstant: 80),
                avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                mainStackView1.trailingAnchor.constraint(equalTo: mainStacklView2.leadingAnchor, constant: -10),
                mainStackView1.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStackView1.widthAnchor.constraint(equalToConstant: 80),
                mainStackView1.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView2.trailingAnchor.constraint(equalTo: mainStacklView3.leadingAnchor, constant: -10),
                mainStacklView2.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView2.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView2.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                mainStacklView3.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView3.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView3.heightAnchor.constraint(equalToConstant: 40),
                descriptionCanal.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
                descriptionCanal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                descriptionCanal.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                gridCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.topAnchor.constraint(equalTo: descriptionCanal.bottomAnchor, constant: 15),
                gridCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }
    func setupNavigationBar() {
        let customBarButtonItem = UIBarButtonItem(customView: buttonForRefactorProfile)
        controller?.navigationItem.rightBarButtonItem = customBarButtonItem
        controller?.navigationItem.title = cat?.login
        controller?.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
extension ProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newCat = cat else {return 0}
        return newCat.publications.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let publications = cat?.publications else {return UICollectionViewCell()}
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GridCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? GridCollectionViewCell {
            let publication = publications[indexPath.row]
            cell.configure(with: publication)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension ProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

