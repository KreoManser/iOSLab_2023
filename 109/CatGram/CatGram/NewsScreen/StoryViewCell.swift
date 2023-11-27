//
//  StoryViewCell.swift
//  CatGram
//
//  Created by Mac on 2023-11-06.
//

import UIKit

class StoryViewCell: UICollectionViewCell {
    // MARK: - Declaration objects
    lazy var photo: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCell settings
extension StoryViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    func configureCell(with story: Story) {
        self.photo.image = story.icon
    }
}

// MARK: - Constraints
extension StoryViewCell {
    private func setupLayouts() {
        addSubview(photo)

        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            photo.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
