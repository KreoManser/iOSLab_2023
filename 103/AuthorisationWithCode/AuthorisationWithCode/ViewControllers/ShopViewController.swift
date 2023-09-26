//
//  ShopViewController.swift
//  AuthorisationWithCode
//
//  Created by Mac on 2023-09-25.
//

import UIKit

class ShopViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var shopTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ShopTableViewCell.self, forCellReuseIdentifier: ShopTableViewCell.reuseIdentifier)
        return table
    }()
    
    private lazy var goToBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButton(title: "Корзина")
        
        button.addTarget(self, action: #selector(goToBucketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var dataSourse: [Product] = [
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20),
        Product(name: "Супер кот", imageName: "buy", cost: 20)
    ]
    
    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupLayouts()
    }
}

// MARK: - Table Protocols
extension ShopViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.reuseIdentifier, for: indexPath) as! ShopTableViewCell
        let product = dataSourse[indexPath.row]
        cell.conigureCell(with: product)
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - ObjC
extension ShopViewController {
    /// вернуться обратно
    @objc func goToBucketButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Constraints
extension ShopViewController {
    /// добавляет констрэины
    private func setupLayouts() {
        view.addSubview(shopTable)
        view.addSubview(goToBucketButton)
        
        NSLayoutConstraint.activate([
            shopTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shopTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shopTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shopTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            goToBucketButton.bottomAnchor.constraint(equalTo: shopTable.bottomAnchor, constant: 35),
            goToBucketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToBucketButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

