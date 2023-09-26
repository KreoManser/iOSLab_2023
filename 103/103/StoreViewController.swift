//
//  StoreViewController.swift
//  103
//
//  Created by Dmitry on 26.09.2023.
//

import UIKit

class StoreViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(StoreTableCell.self, forCellReuseIdentifier: StoreTableCell.reuseIdentifire)
        return table
    }()
    
    var dataSource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addProducts()
        
        view.addSubview(tableView)
        
        title = "Магазин"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTableConstraints()
    }
    
    func addProducts() {
        addProductToTable(
            Product(image: UIImage(named: "milk") ?? UIImage.remove, name: "Молоко", cost: 75),
            Product(image: UIImage(named: "pashtet") ?? UIImage.remove, name: "Паштет", cost: 130),
            Product(image: UIImage(named: "bread") ?? UIImage.remove, name: "Хлеб", cost: 40),
            Product(image: UIImage(named: "cheese") ?? UIImage.remove, name: "Cыр", cost: 300),
            Product(image: UIImage(named: "cucumbers") ?? UIImage.remove, name: "Огурцы", cost: 100),
            Product(image: UIImage(named: "tomatos") ?? UIImage.remove, name: "Помидоры", cost: 120))
    }
    
    func addProductToTable(_ product: Product...) {
        product.forEach { dataSource.append($0) }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableCell.reuseIdentifire, for: indexPath) as! StoreTableCell
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func setUpTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}
