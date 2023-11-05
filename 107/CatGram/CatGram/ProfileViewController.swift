import UIKit

class ProfileViewController: UIViewController {

    var posts: [Post] = []
    let authVC = AuthorizationViewController()
    var user: User?
    private var dataManager = DataManager()

    init() {
//        self.user = authVC.users[0]
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
//        user = authVC.users[0]
        setupLayout()
//        collectionView.reloadData()
    }

    private func setupLayout() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(usernameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),

            avatarImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 70),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 70),

            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
//        let selectedPost = posts[indexPath.row]
        let postDetailVC = ListOfPostsViewController(index: indexPath)
//        postDetailVC.delegate = self
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
}
extension ProfileViewController: PostTableViewCellDelegate {
    func reloadArrayAfterDeleting(_ postTableViewCell: PostTableViewCell, didDeletePost post: Post) {
//        if let index = posts.firstIndex(where: { $0.id == post.id }) {
//            posts.remove(at: index)
//        }
        print("****** 1) posts array HERE: \(posts)")
//        print("delete post: \(post)")
        posts = dataManager.syncGetPosts()
        print("****** 2) posts array HERE: \(posts)")
        collectionView.reloadData()
    }
}
extension ProfileViewController: AuthorizationViewControllerDelegate {
    func reloadUserAfterLogin(_ authVC: AuthorizationViewController) {
        user = authVC.users[0]
        usernameLabel.text = user?.username
        descriptionLabel.text = user?.description
        avatarImageView.image = user?.profileImage
    }
}
