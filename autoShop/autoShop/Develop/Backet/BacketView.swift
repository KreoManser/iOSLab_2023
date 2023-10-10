//
//  BacketView.swift
//  autoShop
//
//  Created by Артур Миннушин on 10.10.2023.
//

import UIKit

class BacketView: UIView {

    enum TableSection {
        case main
        case secondary
    }
    
    var data: [Auto] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Auto>?
    
    lazy var shopLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var tableView = UITableView()
    
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
    
    func configureData(dataSource: [Auto]) {
        data = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

