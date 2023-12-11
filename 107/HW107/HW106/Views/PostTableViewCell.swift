import UIKit

protocol PostTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    private lazy var postNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postAvatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postCommentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postShareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postFavouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postDeleteButton: UIButton = {
        let action = UIAction { [weak self] _ in
            guard let index = self?.getIndexPath() else { return }
            self?.delegate?.presentAlert(indexPath: (index))
        }
        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var delegate: PostTableAlertDelegate?
    weak var superView: UITableView?
    private var isLiked: Bool = false
    private var post: Post?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupLayouts()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    func getIndexPath() -> IndexPath {
        guard let indexPath = superView?.indexPath(for: self) else { return IndexPath() }
        return indexPath
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func configureCell(_ post: Post, isLiked: Bool) {
        postImageView.image = UIImage(named: post.postImageName)
        postDescriptionLabel.text = post.postDescription
        postDateLabel.text = post.postDate
        Task {
            let user = await LoginDataManager.loginShared.getCurUser()
            postNameLabel.text = user.login
            postAvatarImageView.image = UIImage(named: user.avatarImageName)
        }
        self.post = post
        if isLiked {
            self.isLiked = true
            postLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            postLikeButton.tintColor = .red
            likeCountLabel.isHidden = false
            guard let user = DataManager.shared.curUser else { return }
            likeCountLabel.text = "Нравится \(String(describing: user.likedPosts.reduce(0) { $1 == post ? $0 + 1 : $0 }))"
        }
    }

    func configureMainScreenPostCell(_ post: Post, isLiked: Bool) {
        postDeleteButton.isHidden = true
        postImageView.image = UIImage(named: post.postImageName)
        postDescriptionLabel.text = post.postDescription
        postDateLabel.text = post.postDate
        let index = Int.random(in: 0..<LoginDataManager.loginShared.getUsersName().count)
        postAvatarImageView.image = UIImage(named: LoginDataManager.loginShared.getUsersAvatarImageName()[index])
        postNameLabel.text = LoginDataManager.loginShared.getUsersName()[index]
        self.post = post
        if isLiked {
            self.isLiked = true
            postLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            postLikeButton.tintColor = .red
            likeCountLabel.isHidden = false
            guard let user = DataManager.shared.curUser else { return }
            likeCountLabel.text = "Нравится \(String(describing: user.likedPosts.reduce(0) { $1 == post ? $0 + 1 : $0 }))"
        }
    }

    func setupLayouts() {
        contentView.addSubview(postAvatarImageView)
        contentView.addSubview(postNameLabel)
        contentView.addSubview(postDeleteButton)
        contentView.addSubview(postLikeButton)
        contentView.addSubview(postCommentButton)
        contentView.addSubview(postShareButton)
        contentView.addSubview(postFavouriteButton)
        contentView.addSubview(postImageView)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(postDescriptionLabel)
        contentView.addSubview(postDateLabel)

        NSLayoutConstraint.activate([
            postAvatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            postAvatarImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            postAvatarImageView.widthAnchor.constraint(equalToConstant: 40),
            postAvatarImageView.heightAnchor.constraint(equalToConstant: 40),

            postNameLabel.leadingAnchor.constraint(equalTo: postAvatarImageView.trailingAnchor,
                constant: 15),
            postNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,
                constant: 20),

            postDeleteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            postDeleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),

            postImageView.topAnchor.constraint(equalTo: postAvatarImageView.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: frame.width),

            postLikeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postLikeButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),

            postCommentButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postCommentButton.leadingAnchor.constraint(equalTo: postLikeButton.trailingAnchor, constant: 10),

            postShareButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postShareButton.leadingAnchor.constraint(equalTo: postCommentButton.trailingAnchor, constant: 10),

            postFavouriteButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postFavouriteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),

            likeCountLabel.topAnchor.constraint(equalTo: postLikeButton.bottomAnchor, constant: 2),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            likeCountLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),
            likeCountLabel.heightAnchor.constraint(equalToConstant: 12),

            postDescriptionLabel.topAnchor.constraint(equalTo: likeCountLabel.bottomAnchor, constant: 5),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10),

            postDateLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 5),
            postDateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10),
            postDateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
}

extension PostTableViewCell {
    private func animateLike() {
        if isLiked {
            UIView.animate(withDuration: 0.2, animations: {
                self.postLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                self.postLikeButton.tintColor = .black
                self.likeCountLabel.isHidden = true
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.postLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.postLikeButton.tintColor = .red
                self.likeCountLabel.isHidden = false
            })
        }
    }

    func setupGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.postImageView.addGestureRecognizer(doubleTapGesture)
    }

    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        animateLike()
        self.isLiked.toggle()
        if isLiked {
            DataManager.shared.saveLikedPost(post: self.post ?? Post(id: -1, postImageName: "", postDescription: "", postDate: ""))
        } else {
            DataManager.shared.deleteLikedPost(post: self.post ?? Post(id: -1, postImageName: "", postDescription: "", postDate: ""))
        }
        guard let user = DataManager.shared.curUser else { return }
        likeCountLabel.text = "Нравится \(user.likedPosts.reduce(0) { $1 == post ? $0 + 1 : $0 })"
        try? DataManager.shared.saveCurrentUser()
    }
}