//
//  GridPublisherCollectionViewCell.swift
//  CatGram
//
//  Created by Нияз Ризванов on 29.10.2023.
//

import UIKit

class GridPublisherCollectionViewCell: UICollectionViewCell {
    lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    override init(frame: CGRect) {
            super.init(frame: frame)
            //addSubview(view)
        contentView.addSubview(view)
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 50),
                view.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
}
