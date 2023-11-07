import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    private lazy var storyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.systemBlue.cgColor
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoryCollectionViewCell {
    func configureCell(_ story: Story) {
        storyImageView.image = UIImage(named: story.imageName)
        userNameLabel.text = story.userName
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func setupLayouts() {
        contentView.backgroundColor = .white

        contentView.addSubview(storyImageView)
        contentView.addSubview(userNameLabel)

        NSLayoutConstraint.activate([
            storyImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            storyImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            storyImageView.widthAnchor.constraint(equalToConstant: 80),
            storyImageView.heightAnchor.constraint(equalToConstant: 80),

            userNameLabel.topAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: 2),
            userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
