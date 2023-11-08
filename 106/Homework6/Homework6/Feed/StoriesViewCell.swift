//
//  StoriesViewCell.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class StoriesViewCell: UICollectionViewCell {
    private lazy var storyPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.red.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(subviews: storyPhoto)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configureCell(with story: Story) {
        self.storyPhoto.image = story.image
    }
}

extension StoriesViewCell {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            storyPhoto.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            storyPhoto.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            storyPhoto.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            storyPhoto.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
