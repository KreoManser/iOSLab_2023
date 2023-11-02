//
//  GridCollectionViewCell.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 02.11.2023.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    var imagePhoto: UIImage?
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func configure(with publisher: Publisher) {
        image.image = publisher.image
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GridCollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
