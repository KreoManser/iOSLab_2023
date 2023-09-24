//
//  busketTableViewCell.swift
//  homework_3
//
//  Created by Кирилл Щёлоков on 24.09.2023.
//

import UIKit

class BusketTableViewCell: UITableViewCell {

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
    
    private lazy var selectButton: UIButton = {
        let selectButton = UIButton()
        return selectButton
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        setUpCellImageView()
        setUpNameLabel()
        setUpCostLabel()
        setUpSelectButton()
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
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setUpNameLabel(){
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setUpCostLabel(){
        contentView.addSubview(costLabel)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        costLabel.textColor = .gray
        costLabel.font = UIFont.systemFont(ofSize: 12)

        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            costLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 8),
        ])

    }
    
    private func setUpSelectButton(){
        contentView.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.setImage(UIImage(named: "selectImage"), for: .normal)
        selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            selectButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            selectButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            selectButton.widthAnchor.constraint(equalToConstant: 24),
            selectButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc
    private func selectButtonAction(){
        if selectButton.image(for: .normal) == UIImage(named: "selectImage") {
            selectButton.setImage(UIImage(named: "unselectedImage"), for: .normal)
        } else {
            selectButton.setImage(UIImage(named: "selectImage"), for: .normal)
        }
    }
    
}

extension UITableViewCell{
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}
