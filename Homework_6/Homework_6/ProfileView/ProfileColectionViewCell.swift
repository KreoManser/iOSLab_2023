//
//  InstagramViewController.swift
//  Homework_6
//
//  Created by err on 29.10.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    let cellImageView: UIImageView = UIImageView()

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
        cellImageView.image = post.image
    }

    private func setUpCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 128),
            cellImageView.heightAnchor.constraint(equalToConstant: 128)
        ])
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
