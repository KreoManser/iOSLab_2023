//
//  HistoryCollectionViewCell.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    lazy var historyImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Cat")
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {

        let hight = frame.size.height
        historyImage.layer.cornerRadius = hight / 2
        contentView.addSubview(historyImage)
        let content = contentView.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            historyImage.topAnchor.constraint(equalTo: content.topAnchor),
            historyImage.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            historyImage.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            historyImage.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        ])
    }

    static var reuseIdentificator: String {
        return String(describing: self)
    }
}
