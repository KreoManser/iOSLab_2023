import UIKit

class ProfileView: UIView, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    lazy var usernameLabel: UILabel = UILabel()
    lazy var buttonsStackView: UIStackView = UIStackView()
    lazy var optionsButton: UIButton = UIButton()
    lazy var profileImageView: UIImageView = UIImageView()
    lazy var infoHorizontalStackView: UIStackView = UIStackView()
    lazy var postsVerticalStackView: UIStackView = UIStackView()
    lazy var postsLabel: UILabel = UILabel()
    lazy var postsCountLabel: UILabel = UILabel()
    lazy var subscribersVerticalStackView: UIStackView = UIStackView()
    lazy var subscribersLabel: UILabel = UILabel()
    lazy var subscribersCountLabel: UILabel = UILabel()
    lazy var subscriptionsVerticalStackView: UIStackView = UIStackView()
    lazy var subscriptionsLabel: UILabel = UILabel()
    lazy var subscriptionsCountLabel: UILabel = UILabel()
    lazy var descriptionLabel: UILabel = UILabel()
    lazy var viewProfileButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAccountNameLabel()
        setUpOptionsButton()
        setUpProfileImageView()
        setUpInfoHorizontalStackView()
        seUpPostsVerticalStackView()
        seUpSubscribersVerticalStackView()
        seUpSubscriptionsVerticalStackView()
        setUpdescriptionLabel()
        setUpViewProfileButton()
        setUpCollectionView()
    }

    private func setUpAccountNameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "CatGram"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 3),
            usernameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }

    private func setUpOptionsButton() {
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.setImage(UIImage(named: "burger-icon"), for: .normal)

        NSLayoutConstraint.activate([
            optionsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            optionsButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            optionsButton.widthAnchor.constraint(equalToConstant: 25),
            optionsButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setUpProfileImageView() {
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "photo-6")
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setUpInfoHorizontalStackView() {
        addSubview(infoHorizontalStackView)
        infoHorizontalStackView.axis = .horizontal
        infoHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        infoHorizontalStackView.distribution = .fillEqually
        infoHorizontalStackView.alignment = .fill

        NSLayoutConstraint.activate([
            infoHorizontalStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            infoHorizontalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                              constant: -20),
            infoHorizontalStackView.heightAnchor.constraint(equalToConstant: 40),
            infoHorizontalStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 30)
        ])
    }

    private func seUpPostsVerticalStackView() {
        infoHorizontalStackView.addSubview(postsVerticalStackView)
        postsVerticalStackView.axis = .vertical
        postsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        postsVerticalStackView.spacing = 5
        postsVerticalStackView.distribution = .fillEqually
        postsVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            postsVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            postsVerticalStackView.leadingAnchor.constraint(equalTo: infoHorizontalStackView.leadingAnchor),
            postsVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            postsVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpPostsCountLabel()
        setUpPostsLabel()
    }

    private func seUpSubscribersVerticalStackView() {
        infoHorizontalStackView.addSubview(subscribersVerticalStackView)
        subscribersVerticalStackView.axis = .vertical
        subscribersVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        subscribersVerticalStackView.spacing = 5
        subscribersVerticalStackView.distribution = .fillEqually
        subscribersVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            subscribersVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            subscribersVerticalStackView.leadingAnchor.constraint(equalTo: postsVerticalStackView.trailingAnchor,
                                                                  constant: 4),
            subscribersVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            subscribersVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpSubscribersCountLabel()
        setUpSubscribersLabel()
    }

    private func seUpSubscriptionsVerticalStackView() {
        infoHorizontalStackView.addSubview(subscriptionsVerticalStackView)
        subscriptionsVerticalStackView.axis = .vertical
        subscriptionsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        subscriptionsVerticalStackView.spacing = 5
        subscriptionsVerticalStackView.distribution = .fillEqually
        subscriptionsVerticalStackView.alignment = .center

        NSLayoutConstraint.activate([
            subscriptionsVerticalStackView.topAnchor.constraint(equalTo: infoHorizontalStackView.topAnchor),
            subscriptionsVerticalStackView.trailingAnchor.constraint(equalTo: infoHorizontalStackView.trailingAnchor),
            subscriptionsVerticalStackView.heightAnchor.constraint(equalToConstant: 40),
            subscriptionsVerticalStackView.widthAnchor.constraint(equalToConstant: 72)
        ])
        setUpSubscriptionsCountLabel()
        setUpSubscriptionsLabel()
    }

    private func setUpPostsCountLabel() {
        postsVerticalStackView.addArrangedSubview(postsCountLabel)
        postsCountLabel.text = "11"
        postsCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

    private func setUpPostsLabel() {
        postsVerticalStackView.addArrangedSubview(postsLabel)
        postsLabel.font = UIFont.boldSystemFont(ofSize: 11)
        postsLabel.text = "Публикации"
    }

    private func setUpSubscribersCountLabel() {
        subscribersVerticalStackView.addArrangedSubview(subscribersCountLabel)
        subscribersCountLabel.text = "123"
        subscribersLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

    private func setUpSubscribersLabel() {
        subscribersVerticalStackView.addArrangedSubview(subscribersLabel)
        subscribersLabel.font = UIFont.boldSystemFont(ofSize: 11)
        subscribersLabel.text = "Подписчики"
    }

    private func setUpSubscriptionsCountLabel() {
        subscriptionsVerticalStackView.addArrangedSubview(subscriptionsCountLabel)
        subscribersCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        subscriptionsCountLabel.text = "11"

    }

    private func setUpSubscriptionsLabel() {
        subscriptionsVerticalStackView.addArrangedSubview(subscriptionsLabel)
        subscriptionsLabel.font = UIFont.boldSystemFont(ofSize: 11)
        subscriptionsLabel.text = "Подписки"
    }

    private func setUpdescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.text = "Мой блог с няшными фотками милых котиков"
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    private func setUpViewProfileButton() {
        addSubview(viewProfileButton)
        viewProfileButton.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(image: UIImage(named: "photo-icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        viewProfileButton.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: viewProfileButton.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: viewProfileButton.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewProfileButton.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewProfileButton.bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalToConstant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 10),

            viewProfileButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            viewProfileButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: -10),
            viewProfileButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10),
            viewProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        viewProfileButton.backgroundColor = .white
        viewProfileButton.layer.borderWidth = 1.0
        viewProfileButton.layer.borderColor = UIColor.black.cgColor
        viewProfileButton.clipsToBounds = true
        viewProfileButton.layer.cornerRadius = 8
        viewProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 1)
    }

    private func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: viewProfileButton.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
