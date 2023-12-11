import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    static let feedCollectionViewCellReuseIdentifier = "FeedCollectionViewCell"

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configureCell(with story: Story) {
        imageView.image = story.avatarImage
        usernameLabel.text = story.username
    }
    func setupLayout() {

        guard imageView.superview == nil else { return }

        contentView.addSubview(usernameLabel)
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 1),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
