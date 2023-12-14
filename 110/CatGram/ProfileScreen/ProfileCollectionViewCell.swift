//
//  ProfileCollectionViewCell.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let someView = UIImageView()
        someView.translatesAutoresizingMaskIntoConstraints = false
        return someView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    func configure(with post: Posts) {
        if let imageData = post.photo, let image = UIImage(data: imageData) {
            imageView.image = image
        } else {
            print("Failure to load image")
            imageView.image = nil
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 128),
            imageView.heightAnchor.constraint(equalToConstant: 128)
        ])
    }
}

extension  UICollectionViewCell {
    static var reuseidentifier: String {
        return String(describing: self)
    }
}
