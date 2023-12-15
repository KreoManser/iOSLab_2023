import UIKit

class ProfileView: UIView {
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var profileAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var profileMoreButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self]_ in
            self?.profileViewController?.settingsScreen()
        }
        button.setImage(UIImage(named: "more"), for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var profileUserInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var publicationsLabel: UILabel = profileInfoLabel("Publications", weight: .regular)
    private lazy var publicationsCountLabel: UILabel = profileInfoLabel("\(String(describing: CoreDataManager.shared.getPostsFromCurUser().count))",
    weight: .medium)

    private lazy var publicsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [publicationsCountLabel, publicationsLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var followsLabel: UILabel = profileInfoLabel("Followers", weight: .regular)
    private lazy var followsCountLabel: UILabel = profileInfoLabel("3455", weight: .medium)

    private lazy var followsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followsCountLabel, followsLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var subsLabel: UILabel = profileInfoLabel("Subs", weight: .regular)
    private lazy var subsCountLabel: UILabel = profileInfoLabel("\(CoreDataManager.shared.getFriendsFromCurUser().count)", weight: .medium)

    private lazy var subsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subsCountLabel, subsLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [publicsStackView, followsStackView, subsStackView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier:
        ProfileCollectionViewCell.reuseIdentifier)
        collection.delegate = self
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    weak var profileViewController: ProfileViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(profileNameLabel)
        addSubview(profileImageView)
        addSubview(profileAddButton)
        addSubview(profileMoreButton)
        addSubview(infoStackView)
        addSubview(profileUserInformationLabel)
        addSubview(profileCollectionView)

        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),

            profileMoreButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            profileMoreButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            profileMoreButton.heightAnchor.constraint(equalToConstant: 29),
            profileMoreButton.widthAnchor.constraint(equalToConstant: 29),

            profileAddButton.trailingAnchor.constraint(equalTo: profileMoreButton.leadingAnchor, constant: -10),
            profileAddButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            profileAddButton.heightAnchor.constraint(equalToConstant: 25),
            profileAddButton.widthAnchor.constraint(equalToConstant: 25),

            profileImageView.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            profileUserInformationLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileUserInformationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 15),

            infoStackView.bottomAnchor.constraint(equalTo: profileUserInformationLabel.topAnchor, constant: -25),
            infoStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),

            profileCollectionView.topAnchor.constraint(equalTo: profileUserInformationLabel.bottomAnchor, constant: 15),
            profileCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            profileCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            profileCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.subsCountLabel.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.profileViewController?.subsScreen()
    }
    func setupDataSource(_ dataSource: UICollectionViewDataSource) {
        profileCollectionView.dataSource = dataSource
    }

    func reloadData() {
        profileCollectionView.reloadData()
        publicationsCountLabel.text = "\(CoreDataManager.shared.getPostsFromCurUser().count)"
    }

    func profileInfoLabel(_ text: String, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: weight)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func configureProfile(user: User) {
        profileImageView.image = UIImage(named: user.avatarImageName)
        profileNameLabel.text = user.login
        profileUserInformationLabel.text = user.login
        subsCountLabel.text = "\(CoreDataManager.shared.getFriendsFromCurUser().count)"
        followsCountLabel.text = "100"
    }
}

extension ProfileView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width / 3 - 4, height: frame.width / 3 - 4)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileViewController?.postScreen(indexPath)
    }
}
