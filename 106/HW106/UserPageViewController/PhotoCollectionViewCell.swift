//
//  PhotoCollectionViewCell.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 30.01.2024.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(model: Post) {
        guard let image = model.avatarImageView else { return }
        self.photoView.image = UIImage(data: image)
    }
    
}
