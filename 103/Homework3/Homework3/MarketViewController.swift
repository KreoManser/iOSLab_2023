//
//  MarketViewController.swift
//  Homework3
//
//  Created by kerik on 28.09.2023.
//

import UIKit

class MarketViewController: UIViewController {
    private lazy var marketLabel: UILabel = {
        let label = UILabel()
        label.text = "Магазин"
        label.textColor = .black
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var marketTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var basketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Корзина", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGray3
        button.addAction(UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true) }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dataSource: [Product] = [
        Product(image: UIImage(named: "maison"), name: "Марджухи", cost: "50000"),
        Product(image: UIImage(named: "owens"), name: "Рики", cost: "99999"),
        Product(image: UIImage(named: "airforce"), name: "Аир форс 1", cost: "10000"),
        Product(image: UIImage(named: "dunk"), name: "Данки ЧБ", cost: "14000"),
        Product(image: UIImage(named: "jordan4"), name: "Жорики 4", cost: "20000"),
        Product(image: UIImage(named: "jordan4"), name: "Жорики 4", cost: "20000"),
        Product(image: UIImage(named: "jordan4"), name: "Жорики 4", cost: "20000"),
        Product(image: UIImage(named: "jordan4"), name: "Жорики 4", cost: "20000")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.navigationItem.hidesBackButton = true
        addSubviews(marketLabel, marketTableView, basketButton, exitButton)
        setLayout()
    }
    
    @objc func basketButtonTapped() {
        let basketViewController = BasketViewController()
        navigationController?.pushViewController(basketViewController, animated: true)
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            marketLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            marketLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            marketTableView.topAnchor.constraint(equalTo: marketLabel.bottomAnchor, constant: 10),
            marketTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            marketTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            marketTableView.bottomAnchor.constraint(equalTo: basketButton.topAnchor, constant: -20),
                        
            basketButton.widthAnchor.constraint(equalToConstant: 223),
            basketButton.heightAnchor.constraint(equalToConstant: 33),
            basketButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -10),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exitButton.widthAnchor.constraint(equalToConstant: 223),
            exitButton.heightAnchor.constraint(equalToConstant: 33),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
