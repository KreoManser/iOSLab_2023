//
//  TrashViewController.swift
//  HW_103
//
//  Created by Азат Зиганшин on 26.09.2023.
//

import UIKit

class BasketViewController: UIViewController {

    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(ShopItemTableViewCell.self, forCellReuseIdentifier: ShopItemTableViewCell.reuseIdentifier)
        return table
    }()
    
    var dataSource: [ShopItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Корзина"
        
        dataSource = [
            ShopItem(name: "MacBook Air M1", avatarImage: UIImage(named: "MacBookAirM1"))]
        
        setupLayout()
    }
    

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopItemTableViewCell.reuseIdentifier, for: indexPath) as! ShopItemTableViewCell
        
        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func setupLayout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
