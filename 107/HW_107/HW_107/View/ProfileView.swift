import UIKit

class ProfileView: UIView {
    private lazy var menuButon: UIButton = UIButton()
    lazy var createContentButton: UIButton = UIButton()
    private lazy var accountsButton: UIButton = UIButton()
    private lazy var avatarImage: UIImageView = UIImageView()
    //    private lazy var fullNameLabel: UILabel = UILabel()
    lazy var countPublicationLabel: UILabel = UILabel()
    private lazy var publicationLabel: UILabel = UILabel()
    private lazy var countSubscribersLabel: UILabel = UILabel()
    private lazy var subscribersLabel: UILabel = UILabel()
    private lazy var countSubscriptionsLabel: UILabel = UILabel()
    private lazy var subscriptionsLabel: UILabel = UILabel()
    private lazy var photosCollectionView: UICollectionView = UICollectionView()
    private lazy var animatedBarView: UIImageView = UIImageView()
    private lazy var topStackView = UIStackView()
    private lazy var publicationStackView = UIStackView()
    private lazy var subscribersStackView = UIStackView()
    private lazy var subscriptionsStackView = UIStackView()
    private lazy var dataAccountStackView = UIStackView()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let screenWidth = UIScreen.main.bounds.width
        let numberOfItemsInRow: CGFloat = 3
        let itemWidth = (screenWidth - (numberOfItemsInRow - 1) * layout.minimumInteritemSpacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: ProfileView Setup
    private func setUp() {
        setUpMenuButton()
        setUpCreateContentButton()
        setUpAccountsButton()
        setUpAvatarImage()
        setUpTopStackView()
        setUpPublicationStackView()
        setUpSubscribersStackView()
        setUpSubscriptionsStackView()
        setUpDataAccountStackView()
        setUpAnimatedBar()
        setUpCollectionView()
    }
    /// Buttons
    private func setUpAccountsButton() {
        addSubview(accountsButton)
        accountsButton.translatesAutoresizingMaskIntoConstraints = false
        accountsButton.setTitle("Kot", for: .normal)
        accountsButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        accountsButton.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            accountsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            accountsButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            accountsButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            accountsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    private func setUpMenuButton() {
        menuButon.setImage(.menu, for: .normal)
        menuButon.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setUpCreateContentButton() {
        createContentButton.setImage(.createContent, for: .normal)
        createContentButton.translatesAutoresizingMaskIntoConstraints = false
    }
    /// Images
    private func setUpAvatarImage() {
        addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = .avatar
        avatarImage.backgroundColor = .white
        avatarImage.layer.borderWidth = 1.0
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = 46
        avatarImage.clipsToBounds = true
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: accountsButton.bottomAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.24),
            avatarImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.24),
            avatarImage.leadingAnchor.constraint(equalTo: accountsButton.leadingAnchor, constant: 30)
        ])
    }
    /// Labels
    private func setUpCountPublicationLabel() {
        countPublicationLabel.translatesAutoresizingMaskIntoConstraints = false
        countPublicationLabel.text = "4"
        countPublicationLabel.font = UIFont(name: "systemFont", size: 16)
        countPublicationLabel.textColor = .white
    }
    private func setUpPublicationLabel() {
        publicationLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationLabel.text = "Публикации"
        publicationLabel.font = UIFont(name: "systemFont", size: 10)
        publicationLabel.textColor = .white
    }
    private func setUpCountSubscribersLabel() {
        countSubscribersLabel.translatesAutoresizingMaskIntoConstraints = false
        countSubscribersLabel.text = "88"
        countSubscribersLabel.font = UIFont(name: "systemFont", size: 16)
        countSubscribersLabel.textColor = .white
    }
    private func setUpSubscribersLabel() {
        subscribersLabel.translatesAutoresizingMaskIntoConstraints = false
        subscribersLabel.text = "Подписчики"
        subscribersLabel.font = UIFont(name: "systemFont", size: 10)
        subscribersLabel.textColor = .white
    }
    private func setUpCountSubscriptionsLabel() {
        countSubscriptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        countSubscriptionsLabel.text = "64"
        countSubscriptionsLabel.font = UIFont(name: "systemFont", size: 16)
        countSubscriptionsLabel.textColor = .white
    }
    private func setUpSubscriptionsLabel() {
        subscriptionsLabel.translatesAutoresizingMaskIntoConstraints = false
        subscriptionsLabel.text = "Подписки"
        subscriptionsLabel.font = UIFont(name: "systemFont", size: 10)
        subscriptionsLabel.textColor = .white
    }
    /// StackViews
    private func  setUpTopStackView() {
        addSubview(topStackView)
        setUpCountPublicationLabel()
        setUpPublicationLabel()
        topStackView.addArrangedSubview(createContentButton)
        topStackView.addArrangedSubview(menuButon)
        topStackView.axis = .horizontal
        topStackView.alignment = .fill
        topStackView.distribution = .fillEqually
        topStackView.spacing = 20
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            topStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            topStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.07),
            topStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    private func setUpPublicationStackView() {
        setUpCountPublicationLabel()
        setUpPublicationLabel()
        configSubStackView(with: publicationStackView)
        publicationStackView.addArrangedSubview(countPublicationLabel)
        publicationStackView.addArrangedSubview(publicationLabel)
    }
    private func setUpSubscribersStackView() {
        setUpCountSubscribersLabel()
        setUpSubscribersLabel()
        configSubStackView(with: subscribersStackView)
        subscribersStackView.addArrangedSubview(countSubscribersLabel)
        subscribersStackView.addArrangedSubview(subscribersLabel)
    }
    private func setUpSubscriptionsStackView() {
        setUpCountSubscriptionsLabel()
        setUpSubscriptionsLabel()
        configSubStackView(with: subscriptionsStackView)
        subscriptionsStackView.addArrangedSubview(countSubscriptionsLabel)
        subscriptionsStackView.addArrangedSubview(subscriptionsLabel)
    }
    private func setUpDataAccountStackView() {
        addSubview(dataAccountStackView)
        dataAccountStackView.translatesAutoresizingMaskIntoConstraints = false
        dataAccountStackView.axis = .horizontal
        dataAccountStackView.alignment = .center
        dataAccountStackView.distribution = .fillEqually
        dataAccountStackView.spacing = 0.2
        NSLayoutConstraint.activate([
            dataAccountStackView.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 10),
            dataAccountStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
            dataAccountStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            dataAccountStackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10)
        ])
    }
    /// AnimateBar
    private func setUpAnimatedBar() {
        addSubview(animatedBarView)
        animatedBarView.image = .bar
        animatedBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animatedBarView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 80),
            animatedBarView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            animatedBarView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.048),
            animatedBarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    /// CollectionView
    private func setUpCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: animatedBarView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    /// Config
    private func configSubStackView(with stackView: UIStackView) {
        dataAccountStackView.addArrangedSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0.2
    }
}
