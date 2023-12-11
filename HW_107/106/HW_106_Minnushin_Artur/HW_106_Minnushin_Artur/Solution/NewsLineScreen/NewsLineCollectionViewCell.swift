//
//  NewsLineCollectionViewCell.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 01.12.2023.
//

import UIKit

class NewsLineCollectionViewCell: UICollectionViewCell {
    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        setupLayot()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayot() {
        NSLayoutConstraint.activate( [
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.topAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        ])
    }
}
