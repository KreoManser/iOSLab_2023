//
//  ShopTableViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 26.09.2023.
//

import UIKit

class ShopTableViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(OutfitTableViewCell.self, forCellReuseIdentifier: OutfitTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 300
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    var dataSource: [Outfit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = Array(arrayLiteral: Outfit(name: "Vintage Leather Jacket", price: "$299", size: "Size: 46(M)", avatarImage: UIImage(named: "leatherjacket.jpeg") ), Outfit(name: "Pink Cropped Blazer", price: "$25.99", size: "Size: 48(XL)", avatarImage: UIImage(named: "croppedblazer.jpeg")), Outfit(name: "Wide Leg Pants", price: "$15", size: "44(S/M)", avatarImage: UIImage(named: "widelegpants.jpeg")), Outfit(name: "Chunky Boots", price: "$120", size: "Size: EUR40", avatarImage: UIImage(named: "boots.jpeg")), Outfit(name: "Pink Summer Floral Dress", price: "$9.99", size: "Size: One size", avatarImage: UIImage(named: "dress.jpeg")))
        self.view.backgroundColor = .white
        view.addSubview(tableView)
        
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

extension ShopTableViewController: UITextViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OutfitTableViewCell.reuseIdentifier, for: indexPath) as! OutfitTableViewCell
        
        let outfit = dataSource[indexPath.row]
        cell.configurationCell(with: outfit)
        
        return cell
    }
}
