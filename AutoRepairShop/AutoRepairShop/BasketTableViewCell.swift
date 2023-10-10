//
//  BasketTableViewCell.swift
//  AutoRepairShop
//
//  Created by Нияз Ризванов on 10.10.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    private lazy var imageCar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var labelNameCar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addCar: UIButton = {
        var action = UIAction { _ in
            //self.shopCarsController?.addBasket()
        }
        
        let button = UIButton()
        button.addAction(action , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Delete", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageCar.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        contentView.addSubview(imageCar)
        contentView.addSubview(labelNameCar)
        contentView.addSubview(labelPrice)
        contentView.addSubview(addCar)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with car: Car) {
        imageCar.image = car.image
        labelNameCar.text = car.name
        labelPrice.text = car.price
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            imageCar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageCar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            imageCar.heightAnchor.constraint(equalToConstant: 75),
            imageCar.widthAnchor.constraint(equalToConstant: 110),
            
            labelNameCar.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            labelNameCar.leadingAnchor.constraint(equalTo: imageCar.trailingAnchor,constant: 10),
            
            labelPrice.topAnchor.constraint(equalTo: labelNameCar.bottomAnchor,constant: 10),
            labelPrice.leadingAnchor.constraint(equalTo: labelNameCar.leadingAnchor),
            
            addCar.topAnchor.constraint(equalTo: labelPrice.bottomAnchor,constant: 10),
            addCar.leadingAnchor.constraint(equalTo: labelNameCar.leadingAnchor),
            addCar.widthAnchor.constraint(equalToConstant: 60),
            addCar.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}

