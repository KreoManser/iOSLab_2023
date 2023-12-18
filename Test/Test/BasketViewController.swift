//
//  BasketViewController.swift
//  Test
//
//  Created by Alina on 10.10.2023.
//

import UIKit

class BasketViewController: UIViewController, TableViewDelegate {
    
    func didSelectCar(_ car: Car) {
        basket.append(car)
        tableView.reloadData() 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carListViewController = segue.destination as? CarListViewController {
            carListViewController.delegate = self
        }
    }
    
    var basket: [Car] = [Car(id: UUID(), model: "Mercedes-Benz", price: 50000, image: UIImage(named: "Mercedes")),
                         Car(id: UUID(), model: "BMW", price: 45000, image: UIImage(named: "bmw")),
                         Car(id: UUID(), model: "Audi", price: 55000, image: UIImage(named: "audi")),
                         Car(id: UUID(), model: "Lamborghini", price: 30000, image: UIImage(named: "lamborghini"))
    ]
    
    
    
    var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupNavigationBar()
        setupLayout()

    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
        }
        
        navigationItem.title = "Basket"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)

    }

}
