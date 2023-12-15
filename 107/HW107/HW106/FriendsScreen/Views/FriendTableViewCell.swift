import UIKit

class FriendTableViewCell: UITableViewCell {
    private lazy var friendsAvatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var friendsNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FriendTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func setupLayouts() {
        contentView.backgroundColor = .white

        contentView.addSubview(friendsAvatarImageView)
        contentView.addSubview(friendsNameLabel)

        NSLayoutConstraint.activate([
            friendsAvatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            friendsAvatarImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            friendsAvatarImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            friendsAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            friendsAvatarImageView.heightAnchor.constraint(equalToConstant: 60),

            friendsNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 25),
            friendsNameLabel.leadingAnchor.constraint(equalTo: friendsAvatarImageView.trailingAnchor, constant: 20)
        ])
    }

    func configure(user: User) {
        friendsNameLabel.text = user.login
        friendsAvatarImageView.image = UIImage(named: user.avatarImageName)
        print(1)
    }
}
