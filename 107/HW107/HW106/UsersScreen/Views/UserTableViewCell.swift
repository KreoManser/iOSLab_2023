import UIKit

class UserTableViewCell: UITableViewCell {
    lazy var userLoginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var userAvatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var subsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var flag = true
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func setupLayouts() {
        contentView.backgroundColor = .white

        contentView.addSubview(userAvatarImageView)
        contentView.addSubview(userLoginLabel)
        contentView.addSubview(subsButton)

        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            userAvatarImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userAvatarImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 60),

            userLoginLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 25),
            userLoginLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 20),

            subsButton.heightAnchor.constraint(equalToConstant: 30),
            subsButton.widthAnchor.constraint(equalToConstant: 100),
            subsButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            subsButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    func configure(user: User) {
        userLoginLabel.text = user.login
        userAvatarImageView.image = UIImage(named: user.avatarImageName)
        let isSub = CoreDataManager.shared.isCurUserSubToUser(user: user)
        if isSub {
            subsButton.setTitle("Subscribed", for: .normal)
            subsButton.backgroundColor = .lightGray
        } else {
            subsButton.setTitle("Subscribe", for: .normal)
            subsButton.backgroundColor = .systemBlue
        }
        if flag {
            let action = UIAction { [weak self] _ in
                CoreDataManager.shared.toggleCurUserSubs(user: user)
                if CoreDataManager.shared.isCurUserSubToUser(user: user) {
                    self?.subsButton.setTitle("Subscribed", for: .normal)
                    self?.subsButton.backgroundColor = .lightGray
                    print("yes")
                } else {
                    self?.subsButton.setTitle("Subscribe", for: .normal)
                    self?.subsButton.backgroundColor = .systemBlue
                    print("no")
                }
            }
            subsButton.addAction(action, for: .touchUpInside)
            flag = false
        }
    }
}
