//
//  BucketViewController.swift
//  HW3
//
//  Created by Kseniya Skvortsova on 30.09.2023.
//

import UIKit

class BucketViewController: UIViewController {
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        return table
    }()
    
    var dataSource: [Product] = []
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        
        dataSource = generateData()
        
        view.backgroundColor = .orange
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        
        setupLayout()
    }
    
    func generateData()->[Product]{
        let data:[Product] = [Product(name: "Fate/Grand Order Lancer Tamamo no Mae",
                                      subtitle: "'Fate/Grand Order' game, Kotobukiya studio, 38 cm, and more more more more more more more more more more more text",
                                      price: "14.700 R",
                                      picImage: UIImage(named: "image1")),
                              Product(name: "Nemesis Venus Ver.",
                                                            subtitle: "'Tower of Fantasy' game, RIBOSE studio, 25 cm",
                                                            price: "15.200 R",
                                                            picImage: UIImage(named: "image3")),
                              Product(name: "Noodle Stopper Ruby Rose",
                                                            subtitle: "'RWBY' title, FuRyu studio, 14 cm",
                                                            price: "2.800 R",
                                                            picImage: UIImage(named: "image6"))]
        return data
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

extension BucketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)
        cell.backgroundColor = .black
        
        return cell
    }
}
