//
//  ProfileCollectionViewCell.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    let cellImage: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpCellImageView()
    }

    func configure(with post: Post) {
        cellImage.image = post.image
    }

    private func setUpCellImageView() {
        contentView.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.contentMode = .scaleAspectFill
        cellImage.clipsToBounds = true

        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 128),
            cellImage.heightAnchor.constraint(equalToConstant: 128)
        ])
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
