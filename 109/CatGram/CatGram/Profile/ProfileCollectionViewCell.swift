//
//  ProfileCollectionViewCell.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 30.10.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let width = imageView.widthAnchor.constraint(equalToConstant: 130)
        let height = imageView.heightAnchor.constraint(equalToConstant: 130)
        width.priority = .init(999)
        height.priority = .init(999)
        height.isActive = true
        width.isActive = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(with publication: ProfilePublication) {
        imageView.image = publication.image
    }

    func setup() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
