//
//  PictureCell.swift
//  CaTGramm
//
//  Created by Rustem on 29.10.2023.
//

import UIKit

class PictureCell: UICollectionViewCell {
    /// identifier to collectionview
    static let identifier = "CalcButtonCell"

    /// getting type of our button
    private(set) var pictureModel: PictureModel!

    var picInCell = UIImageView()
    /// adding UI properties to our cell
    func setupUI() {
        self.addSubview(picInCell)
        self.picInCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.picInCell.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.picInCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.picInCell.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.picInCell.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func configureCell(_ image: UIImage) {
        picInCell.image = image
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.picInCell.removeFromSuperview()
    }
}
