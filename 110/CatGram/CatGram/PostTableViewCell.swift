import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func reloadArrayAfterDeleting(_ postTableViewCell: PostTableViewCell, didDeletePost post: Post)
}

class PostTableViewCell: UITableViewCell {

    var viewController: UIViewController?
    private var post: Post?
    private let dataManager = DataManager()
    var dateFormatter = DateFormatter()
    var user: User?
    weak var delegate: PostTableViewCellDelegate?

    lazy var likeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "beforeLike")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()

// элементы публикации
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = user?.profileImage, let conImage = UIImage(data: imageData) {
            image.image = conImage
        }
        //        image.image = user?.profileImage
        image.layer.cornerRadius = 50 / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user?.username
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    lazy var postButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.showPostOptions()
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        button.setTitle("...", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var countOfLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

// метод для показа функций кнопки поста
    func showPostOptions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            if let selectedPost = self.post {
                Task {
                    let deletingResult = await self.dataManager.asyncDelete(post: selectedPost)
                    if deletingResult {
                        self.delegate?.reloadArrayAfterDeleting(self, didDeletePost: selectedPost)
                        let deletedAlert = UIAlertController(title: "Удалено", message: "Пост успешно удален", preferredStyle: .alert)
                        deletedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.viewController?.present(deletedAlert, animated: true, completion: nil)
                    } else {
                        let errorAlert = UIAlertController(title: "Ошибка", message: "Не удалось удалить пост", preferredStyle: .alert)
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.viewController?.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.viewController?.present(alertController, animated: true, completion: nil)
    }

// инициализатор внутренний
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        setupLayout()
        setupGestureRecognizer()
    }
// инициализатор ячейки вне
    func configureCell(with post: Post, user: User, viewController: UIViewController) {
        self.viewController = viewController
        self.post = post
        self.user = user
        usernameLabel.text = user.username
        captionLabel.text = post.caption
        if let imageData = user.profileImage, let conImage = UIImage(data: imageData) {
            avatarImageView.image = conImage
        }
//        avatarImageView.image = user.profileImage
        if let imagePostData = post.image, let conImagePost = UIImage(data: imagePostData) {
            postImageView.image = conImagePost
        }
//        postImageView.image = post.image
        countOfLikesLabel.text = String(post.countOfLikes) + " likes"
        dateLabel.text = dateFormatter.string(from: post.date)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        postImageView.image = nil
    }
//!!!!!!!!!!!!
// анимация лайка
    @objc func likeAnimate(_ gesture: UITapGestureRecognizer) {
        guard let unrPost = post else {return}
        if likeImageView.image == UIImage(named: "beforeLike") {
            UIView.animate(withDuration: 0.3, animations: {
                self.likeImageView.image = UIImage(named: "afterLike")
            }, completion: { _ in
//                self.dataManager.toLikePost(post: unrPost)
                print("from post table view cell")}
            )
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.likeImageView.image = UIImage(named: "beforeLike")
            }, completion: { _ in
//                self.dataManager.toUnlikePost(post: unrPost)
                print("from post table view cell")}
            )
        }
    }
    func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeAnimate(_:)))
        likeImageView.addGestureRecognizer(tapGesture)
    }

    func setupLayout() {

        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(postImageView)
        contentView.addSubview(postButton)
        contentView.addSubview(countOfLikesLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likeImageView)

        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 70),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -250),

            avatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50.0),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 18.0),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100.0),

            postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40.0),
            postButton.widthAnchor.constraint(equalToConstant: 50.0),

            likeImageView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likeImageView.heightAnchor.constraint(equalToConstant: 22.0),
            likeImageView.widthAnchor.constraint(equalToConstant: 22.0),

            countOfLikesLabel.topAnchor.constraint(equalTo: likeImageView.bottomAnchor, constant: 5),
            countOfLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            countOfLikesLabel.heightAnchor.constraint(equalToConstant: 25.0),
            countOfLikesLabel.widthAnchor.constraint(equalToConstant: 60.0),

            captionLabel.topAnchor.constraint(equalTo: countOfLikesLabel.bottomAnchor, constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            captionLabel.heightAnchor.constraint(equalToConstant: 20.0),

            dateLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30.0),
            dateLabel.widthAnchor.constraint(equalToConstant: 80.0)
        ])

    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}