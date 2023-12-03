//
//  MainView.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

class MainView: UIView {
    // MARK: - Declaration objects
    weak var controller: MainViewController?
    var labelTapAction: (() -> Void)?
    private let support = SupportFunctions()
    private var link = ""
    private var currentUser = User()
    private let userDefailts = UserDefaults.standard
    private let userKey = "is_log_user"

    lazy var exitButton: UIButton = {
        let button = support.createButtonWithImage(UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? UIImage())
        let action = UIAction { _ in
            self.userDefailts.set(false, forKey: self.userKey)
            self.controller?.presentLogScreen()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 48
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var amountOfPublicationsLabel: UILabel = {
        support.createAmountLabel("10")
    }()
    lazy var amountOfSubscribersLabel: UILabel = {
        support.createAmountLabel("100")
    }()
    lazy var amountOfSubscriptionsLabel: UILabel = {
        let label = support.createAmountLabel("200")
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    lazy var publicationsLabel: UILabel = {
        support.createDescriptionLabel("Publications")
    }()
    lazy var subscribersLabel: UILabel = {
        support.createDescriptionLabel("Subscribers")
    }()
    lazy var subscriptionsLabel: UILabel = {
        let label = support.createDescriptionLabel("Subscriptions")
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    lazy var nameLabel: UILabel = {
        support.createAmountLabel("Name")
    }()
    lazy var descriprionLabel: UILabel = {
        support.createDescriptionLabel("Descriprion \nDescriprion descriprion descriprion \nDescriprion")
    }()
    private lazy var linkLabel: UILabel = {
        support.createDescriptionLabel("Publications")
    }()
    lazy var editProfileButton: UIButton = {
        let button = support.createButton("Edit profile")
        return button
    }()
    lazy var shareProfileButton: UIButton = {
        support.createButton("Share profile")
    }()
    lazy var postsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 1
        let itemSize = (screenWidth - 2) / 3

        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        let posts = UICollectionView(frame: .zero, collectionViewLayout: layout)
        posts.translatesAutoresizingMaskIntoConstraints = false
        posts.backgroundColor = .white
        posts.delegate = self
        posts.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        return posts
    }()

    // MARK: - Init
    init(frame: CGRect, user: inout User) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayouts()
        if let icon = user.iconUrl {
            support.setImageAsync(url: icon, imageView: &iconImage)
        } else {
            let url: URL? = URL(string: "https://clck.ru/36N8jR")
            user.iconUrl = url
            support.setImageAsync(url: url, imageView: &iconImage)
        }
        currentUser = user
        setupLinkLabel(link: user.link)
        nameLabel.text = user.nick
        amountOfPublicationsLabel.text = String(user.amountOfPosts)
        amountOfSubscribersLabel.text = String(user.amountOfSubscribers)
        amountOfSubscriptionsLabel.text = String(user.amountOfSubscribtions)
        descriprionLabel.text = String(user.description)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Items Delegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        controller?.showDetailScreen(indexPath)
    }
    func updateAmount(_ amount: Int) {
        amountOfPublicationsLabel.text = String(amount)
    }
}

// MARK: - Support things
extension MainView {
    func setAmountOfPosts(_ amount: Int) {
        amountOfPublicationsLabel.text = String(amount)
    }
    func setButtonAction() {
        guard let action = controller?.setEditAction(user: currentUser) else { return }
        editProfileButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: - ObjC
extension MainView {
    private func setupLinkLabel(link: String) {
        linkLabel.isUserInteractionEnabled = true
        self.link = link
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkLabelTapped(_:)))
        linkLabel.addGestureRecognizer(tapGesture)
        linkLabel.textColor = .link
        linkLabel.text = link
    }
    @objc private func linkLabelTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: self.link) {
            UIApplication.shared.open(url)
        }
    }

    @objc private func labelTapped() {
        labelTapAction?()
    }
}

// MARK: - Constraints
extension MainView {
    private func setupLayouts() {
        let postsStackView = support.createSV([amountOfPublicationsLabel, publicationsLabel])
        let subscribersStackView = support.createSV([amountOfSubscribersLabel, subscribersLabel])
        let subscriptionsStackView = support.createSV([amountOfSubscriptionsLabel, subscriptionsLabel])
        let accountActivityStackView = support.createSV([postsStackView, subscribersStackView, subscriptionsStackView], axis: .horizontal)

        let accountInfoStackView = support.createSV([nameLabel, descriprionLabel, linkLabel], align: .fill)

        let buttonsStackView = support.createSV([editProfileButton, shareProfileButton], axis: .horizontal, align: .fill)
        buttonsStackView.spacing = 5

        addSubview(exitButton)
        addSubview(iconImage)
        addSubview(accountActivityStackView)
        addSubview(accountInfoStackView)
        addSubview(buttonsStackView)
        addSubview(postsCollectionView)

        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            exitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),

            iconImage.topAnchor.constraint(equalTo: exitButton.bottomAnchor),
            iconImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            iconImage.heightAnchor.constraint(equalToConstant: 96),
            iconImage.widthAnchor.constraint(equalToConstant: 96),

            accountActivityStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            accountActivityStackView.topAnchor.constraint(equalTo: iconImage.topAnchor, constant: 20),

            accountInfoStackView.leadingAnchor.constraint(equalTo: iconImage.leadingAnchor),
            accountInfoStackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 3),
            accountInfoStackView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 20) / 2),

            buttonsStackView.topAnchor.constraint(equalTo: accountInfoStackView.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: accountInfoStackView.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: accountActivityStackView.trailingAnchor),

            postsCollectionView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 50),
            postsCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
