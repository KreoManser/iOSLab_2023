//
//  PostCollectionViewCell.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    // MARK: - Declaration objects
    lazy var photoOfPost: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCell settings
extension PostCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configureCell(with post: Post) {
        self.photoOfPost.image = UIImage(data: post.photos)
    }
}

// MARK: - Constraints
extension PostCollectionViewCell {
    private func setupLayouts() {
        addSubview(photoOfPost)

        NSLayoutConstraint.activate([
            photoOfPost.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoOfPost.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photoOfPost.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            photoOfPost.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
