//
//  StoriesCollectionViewCell.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 04.02.2024.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storiesImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(model: Model) {
        storiesImageView.image = model.avatarImageView
    }
}
