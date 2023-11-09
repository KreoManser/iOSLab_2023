//
//  StoryCollectionViewCell.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.layer.cornerRadius = 44
        image.clipsToBounds = true
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension StoryCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
