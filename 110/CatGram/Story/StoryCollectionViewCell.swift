//
//  StoryCollectionViewCell.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    lazy var imageview: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpImageView() {
        contentView.addSubview(imageview)
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 20
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageview.heightAnchor.constraint(equalToConstant: 40),
            imageview.widthAnchor.constraint(equalToConstant: 40)

        ])
    }

    func configure(with story: StoryAvatar) {
        imageview.image = story.image
    }
}

extension  UICollectionViewCell {
    static var storyID: String {
        return String(describing: self)
    }
}
