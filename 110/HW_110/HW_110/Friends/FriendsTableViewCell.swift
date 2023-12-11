import UIKit
class FriendsTableViewCell: UITableViewCell {
    lazy var avatar: UIImageView = UIImageView()
    lazy var name: UILabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        setUpAvatar()
        setUpName()
    }
    func setUpAvatar() {
        contentView.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .white
        avatar.layer.borderWidth = 1.0
        avatar.layer.masksToBounds = false
        avatar.layer.cornerRadius = 18
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        NSLayoutConstraint.activate([
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            avatar.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08),
            avatar.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    func setUpName() {
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "boldSystemFont", size: 8)
        name.textColor = .white
        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            name.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            name.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
    }
    func configure(user: User) {
        self.avatar.image = UIImage()
        self.name.text = user.login
    }
}
extension FriendsTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
