//
//  ShopView.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import UIKit

class ShopView: UIView {
    
    let data: [Auto] = []
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Магазин"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var tableView = UITableView()
    
    weak var shopController: ShopController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Indentifire")
        
        addSubview(shopLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            shopLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            shopLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: shopLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    func configureTable(dataSource: UITableViewDataSource) {
        
        tableView.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

