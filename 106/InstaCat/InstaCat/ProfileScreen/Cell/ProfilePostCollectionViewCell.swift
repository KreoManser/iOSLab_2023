//
//  ProfilePostCollectionViewCell.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import UIKit

class ProfilePostCollectionViewCell: UICollectionViewCell {
    // MARK: - UI elements
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImageView)
        configureUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePostCollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func configureCell(_ imageName: String) {
        postImageView.image = UIImage(named: imageName)
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
