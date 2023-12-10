//
//  PublicationCollectionViewCell.swift
//  106Tukaev
//
//  Created by surexnx on 30.10.2023.
//

import UIKit

class PublicationCollectionViewCell: UICollectionViewCell {

    lazy var image: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with publication: Publication) {
        self.image.image = UIImage(named: publication.images.first?.nameImage ?? "нет")
    }

    private func setupLayout() {
        let content = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            image.topAnchor.constraint(equalTo: content.topAnchor),
            image.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        ])
    }
}

extension PublicationCollectionViewCell {
    static var reuseIdentificator: String {
        return String(describing: self)
    }
}
