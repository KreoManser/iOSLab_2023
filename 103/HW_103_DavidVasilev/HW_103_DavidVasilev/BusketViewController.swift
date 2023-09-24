//
//  BusketViewController.swift
//  HW_103_DavidVasilev
//
//  Created by Давид Васильев on 24.09.2023.
//

import UIKit

class BusketViewController: UIViewController, UITableViewDelegate {
    
    var dataSource: [Product ] = []
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register( ProductInBusketTableViewCell.self, forCellReuseIdentifier: ProductInBusketTableViewCell.reuseIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let pattern = Product(name: "Honey",price: 560.5,productImage:UIImage(named:"honey2")!, addInBusketButton: UIButton())
        dataSource = Array(repeating: pattern,count: 30)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
extension BusketViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductInBusketTableViewCell.reuseIdentifier, for: indexPath) as! ProductInBusketTableViewCell
        
        let product = dataSource[indexPath.row]
        cell.layer.borderWidth = 1
        cell.configureCell(with: product)
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(exitButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
        return cell
    }
    @objc func exitButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
