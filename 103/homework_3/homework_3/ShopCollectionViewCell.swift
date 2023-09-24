//
//  ShopTableViewCell.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    private lazy var cellImageView : UIImageView = {
        let cellImageView = UIImageView()
        return cellImageView
    }()
    
    private lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    private lazy var costLabel : UILabel = {
        let costLabel = UILabel()
        return costLabel
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        setUpCellImageView()
        setUpNameLabel()
        setUpCostLabel()        
    }
    
    func configureProduct(with product : (UIImage?, String, String)){
        cellImageView.image = product.0
        costLabel.text = product.1 + "$"
        nameLabel.text = product.2
    }
    
    private func setUpCellImageView(){
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.widthAnchor.constraint(equalToConstant: 170),
            cellImageView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func setUpNameLabel(){
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 170),
        ])
    }
    
    private func setUpCostLabel(){
        contentView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.textColor = .gray
        costLabel.font = UIFont.systemFont(ofSize: 12)

        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 2),
            costLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])

    }
}

extension UICollectionViewCell{
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}
