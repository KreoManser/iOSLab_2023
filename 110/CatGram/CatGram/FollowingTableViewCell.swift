import UIKit

class FollowingTableViewCell: UITableViewCell {

    private let dataManager = DataManager()
    var user: User?

    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = user?.profileImage, let conImage = UIImage(data: imageData) {
            image.image = conImage
        }
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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    func configureCell(user: User) {
        self.user = user
        usernameLabel.text = user.username
        if let imageData = user.profileImage, let conImage = UIImage(data: imageData) {
            avatarImageView.image = conImage
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }

    func setupLayout() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50.0),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 18.0),
            usernameLabel.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }

}
