//
//  ShopViewController.swift
//  IosHW103
//
//  Created by Ильмир Шарафутдинов on 08.01.2024.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var tableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 200
        
        return table
    }()
    
    var dataSource: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.append(contentsOf: [
                User(name: "Iphone 13 Pro", price: "Price: 89 000", avatarImageView: UIImage(named: "айфон13 про")),
                User(name: "Iphone 13", price: "Price: 80 000", avatarImageView: UIImage(named: "13")),
                User(name: "Iphone 12", price: "Price: 70 000", avatarImageView: UIImage(named: "12")),
                User(name: "Iphone 11", price: "Price: 62 999", avatarImageView: UIImage(named: "11")),
                User(name: "Iphone 10", price: "Price: 30 000", avatarImageView: UIImage(named: "10")),
                User(name: "Iphone 8", price: "Price: 20 000", avatarImageView: UIImage(named: "8"))
            ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        view.backgroundColor = .white
    }
}
extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell

        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 
    }
}


