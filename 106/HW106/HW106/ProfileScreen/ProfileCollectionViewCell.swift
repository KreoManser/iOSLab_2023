import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    private lazy var profilePostImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 2
        image.layer.borderWidth = 0.25
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileCollectionViewCell {
    func setupLayouts() {
        contentView.addSubview(profilePostImageView)

        NSLayoutConstraint.activate([
            profilePostImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            profilePostImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            profilePostImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            profilePostImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configureCell(_ post: Post) {
        profilePostImageView.image = post.postImage
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
