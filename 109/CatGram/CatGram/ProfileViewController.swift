import UIKit

class ProfileViewController: UIViewController {

    var posts: [Post] = []
    var user: User?
    private var dataManager = DataManager()
    let feedVC = FeedViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = user?.username
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = user?.description
        label.numberOfLines = 2
        return label
    }()
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = user?.profileImage
        image.layer.cornerRadius = 80 / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
//    показ алерт экрана для настроек (на данный момент функция выхода из аккаунта)
    lazy var settingsButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.settingsButtonOptions()
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        button.setTitle("...", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        return button
    }()
    func settingsButtonOptions() {
        let alertController = UIAlertController(title: "Настройки", message: nil, preferredStyle: .alert)

        let exitAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.dataManager.logOutDefaults()
            let navController = UINavigationController()
            let authVC = AuthorizationViewController()
            self.tabBarController?.view.removeFromSuperview()
            self.tabBarController?.removeFromParent()
            navController.setViewControllers([authVC], animated: true)

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = authVC
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alertController.addAction(exitAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
// collectionView для отображения постов в profile
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.bounds.width - 2) / 3, height: (view.bounds.width - 2) / 3)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        posts = dataManager.syncGetPosts()
        setupLayout()
        collectionView.reloadData()
    }

    private func setupLayout() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(usernameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(avatarImageView)
        view.addSubview(settingsButton)

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100),
            usernameLabel.heightAnchor.constraint(equalToConstant: 25),

            avatarImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 100),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 70),

            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            settingsButton.widthAnchor.constraint(equalToConstant: 80),
            settingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionViewCell.reuseIdentifier,
            for: indexPath) as? PostCollectionViewCell
        cell?.configureCell(with: posts[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedUser = user {
            let listOfPostsDetailVC = ListOfPostsViewController(index: indexPath, user: selectedUser, posts: posts)
            listOfPostsDetailVC.delegate = self
            navigationController?.pushViewController(listOfPostsDetailVC, animated: true)
        }
    }
}

extension ProfileViewController: ListOfPostsViewControllerDelegate {
    func reloadArrayAfterDeletingFromList(_ listOfPostsViewController: ListOfPostsViewController, didDeletePost post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
        }
        collectionView.reloadData()
    }
}

