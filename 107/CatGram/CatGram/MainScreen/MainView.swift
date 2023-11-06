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
    private let support = SupportFunctions()

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
        support.createAmountLabel("200")
    }()
    lazy var publicationsLabel: UILabel = {
        support.createDescriptionLabel("Publications")
    }()
    lazy var subscribersLabel: UILabel = {
        support.createDescriptionLabel("Subscribers")
    }()
    lazy var subscriptionsLabel: UILabel = {
        support.createDescriptionLabel("Subscriptions")
    }()
    lazy var nameLabel: UILabel = {
        support.createAmountLabel("Name")
    }()
    lazy var descriprionLabel: UILabel = {
        support.createDescriptionLabel("Descriprion \nDescriprion descriprion descriprion \nDescriprion")
    }()
    lazy var linkLabel: UILabel = {
        let label = support.createDescriptionLabel("@t.me/evaklq")
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkLabelTapped(_:)))
        label.addGestureRecognizer(tapGesture)
        label.textColor = .link
        return label
    }()
    lazy var editProfileButton: UIButton = {
        support.createButton("Edit profile")
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
            getImageAsync(url: icon)
        } else {
            let url: URL? = URL(string: "https://clck.ru/36N8jR")
            user.iconUrl = url
            getImageAsync(url: url)
        }
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
    func getImageAsync(url: URL?) {
        guard let url = url else { return }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.iconImage.image = image
                    print("Image loaded successfully")
                }
            }
        }
        dataTask.resume()
    }

    func setAmountOfPosts(_ amount: Int) {
        amountOfPublicationsLabel.text = String(amount)
    }
}

// MARK: - ObjC
extension MainView {
    @objc func linkLabelTapped(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://t.me/evaklq") {
            UIApplication.shared.open(url)
        }
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

        addSubview(iconImage)
        addSubview(accountActivityStackView)
        addSubview(accountInfoStackView)
        addSubview(buttonsStackView)
        addSubview(postsCollectionView)

        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
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
