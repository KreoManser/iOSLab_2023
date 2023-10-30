import UIKit

protocol PostTableAlertDelegate: AnyObject {
    func presentAlert(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    private lazy var postNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = "timerglOoOt"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var postAvatarImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Avatar"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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

    private lazy var postDeleteButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.delegate?.presentAlert(indexPath: (self?.getIndexPath())!)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostTableViewCell {
    func getIndexPath() -> IndexPath {
        return (superView?.indexPath(for: self))!
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func configureCell(_ post: Post) {
        postImageView.image = post.postImage
        postDescriptionLabel.text = post.postDescription
        postDateLabel.text = post.postDate
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

            postImageView.topAnchor.constraint(equalTo: postAvatarImageView.bottomAnchor, constant: 20),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: frame.width-20),

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

            postDescriptionLabel.topAnchor.constraint(equalTo: postLikeButton.bottomAnchor, constant: 5),
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
