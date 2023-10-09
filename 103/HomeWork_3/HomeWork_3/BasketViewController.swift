//
//  BasketViewController.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 24.09.2023.
//

import UIKit

class BasketViewController: UIViewController {

    private lazy var viewForLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelBasket: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableBasket: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
//        table.separatorStyle = .none
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 140
        return table
    }()
    
    private var  dataSourse: [ProductCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewForLabel)
        view.addSubview(labelBasket)
        view.addSubview(tableBasket)
        
        setupData()
        
        configureElement()
        
        setupLayout()
    }
    
    private func setupData() {
        dataSourse = [
            ProductCard(photoProduct: UIImage(named: "macbook"), descrption: "Macbook air M1 на 512gb", count: "Количество: 1"),
            ProductCard(photoProduct: UIImage(named: "case_for_macbook"), descrption: "Hardcase for Macbook air 13", count: "Количество: 1"),
            ProductCard(photoProduct: UIImage(named: "iphone_15"), descrption: "Apple iPhone 15 128GB Black", count: "Количество: 2"),
            ProductCard(photoProduct: UIImage(named: "apple_watch"), descrption: "Apple Watch Ultra 49mm", count: "Количество: 1"),
            ProductCard(photoProduct: UIImage(named: "strap_for_watch"), descrption: "Кожаные ремешки для Apple Watch Ultra", count: "Количество: 3")
        ]
    }
    
    private func configureElement() {
        view.backgroundColor = .white
        
        navigationItem.title = "Корзина"
        
        viewForLabel.backgroundColor = .tintColor
        
        labelBasket.text = "Корзина"
        labelBasket.textColor = .white
        labelBasket.font = UIFont.systemFont(ofSize: 40)
        labelBasket.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewForLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewForLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForLabel.heightAnchor.constraint(equalToConstant: 60),
            
            labelBasket.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            labelBasket.bottomAnchor.constraint(equalTo: viewForLabel.bottomAnchor,constant: -5),
            
            tableBasket.topAnchor.constraint(equalTo: viewForLabel.bottomAnchor),
            tableBasket.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableBasket.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableBasket.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseIdentifier , for: indexPath) as! BasketTableViewCell

        let card = dataSourse[indexPath.row]
        
        cell.configureCell(with: card)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
}
