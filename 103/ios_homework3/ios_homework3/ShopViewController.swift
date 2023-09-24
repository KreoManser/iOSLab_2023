//
//  ShopViewController.swift
//  ios_homework3
//
//  Created by Аделя Миннехузина on 24.09.2023.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ShopTableViewCell.self, forCellReuseIdentifier: ShopTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 150
        return table
    }()
    
    var dataSource: [Shop] = []
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = Array(repeating: Shop(sweaterImage: UIImage(named: "orange"), sweaterName: "Свитер", sweaterPrice: "1499.99 руб."), count: 50)
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.reuseIdentifier, for: indexPath) as! ShopTableViewCell
        
        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        
        return cell
    }
}
