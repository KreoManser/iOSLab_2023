//
//  ShopViewController.swift
//  HW_103
//
//  Created by Азат Зиганшин on 26.09.2023.
//

import UIKit

class ShopViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        //table.separatorStyle = .none
        table.register(ShopItemTableViewCell.self, forCellReuseIdentifier: ShopItemTableViewCell.reuseIdentifier)
        return table
    }()
    
    var dataSource: [ShopItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Магазин"
        dataSource = [
            ShopItem(name: "MacBook Air M2", avatarImage: UIImage(named: "MacBookAirM2")),
            ShopItem(name: "MacBook Air M1", avatarImage: UIImage(named: "MacBookAirM1")),
            ShopItem(name: "IPhone 15 Pro", avatarImage: UIImage(named: "Iphone15Pro")),
            ShopItem(name: "IPhone 14 Pro", avatarImage: UIImage(named: "Iphone14Pro")),
            ShopItem(name: "Apple Watch 8", avatarImage: UIImage(named: "AppleWatch8")),
            ShopItem(name: "Mac Mini M1", avatarImage: UIImage(named: "MacMiniM1")),
            ShopItem(name: "AirPods Pro", avatarImage: UIImage(named: "AirPodsPro")),
            ShopItem(name: "AirPods Max", avatarImage: UIImage(named: "AirPodsMax")),
            ShopItem(name: "IMac 27", avatarImage: UIImage(named: "IMac27")),
            ShopItem(name: "IPad Pro 11", avatarImage: UIImage(named: "IPadPro11"))
        ]
        
        setupLayout()
    }
}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
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

