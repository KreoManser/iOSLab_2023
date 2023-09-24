//
//  ShopViewController.swift
//  HomeWork_3
//
//  Created by Камил Хайрутдинов on 24.09.2023.
//

import UIKit

class ShopViewController: UIViewController {

    // MARK: - UI elements
    
    // MARK: - Label
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Магазин"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Buttons
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Вернуться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var shoppingBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .darkGray
        button.setTitle("Корзина", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - TsbleView
    lazy var ProductTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        return tableView
    }()
    // MARK: - Data array for TableView
    let dataSource: [Product] = [
        Product(image: UIImage(named: "mac"), name: "Мак 2025", price: "99000", description: "Новый мак, революция от апле"),
        Product(image: UIImage(named: "iphonePro"), name: "Айфон про", price: "150000", description: "Сами угадывайте какой это ифон"),
        Product(image: UIImage(named: "iphone15pro"), name: "Айфон 15 про", price: "200000", description: "революция в ленейне про ифонов"),
        Product(image: UIImage(named: "appleWatch"), name: "Часы спорт сяоми", price: "50000", description: "партия гордится тобой!"),
        Product(image: UIImage(named: "macbookPro13"), name: "Макбук про 2022", price: "150000", description: "просто макбук"),
        Product(image: UIImage(named: "supra"), name: "Тойота супра", price: "2000000", description: "жузет 3.0 vvti с турбо от камаза"),
        Product(image: UIImage(named: "priora"), name: "Приора", price: "500000", description: "бпан"),
        Product(image: UIImage(named: "iphone15"), name: "ифон 15", price: "1234", description: "Фотосессия c iphone 15")
    ]
    
    // MARK: - Lise cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtonstrigger()
    }
    
    // MARK: - Setup layot func
    private func setupLayout() {
        view.backgroundColor = UIColor(displayP3Red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [shoppingBasketButton, exitButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 25
        
        view.addSubview(titleLabel)
        view.addSubview(ProductTableView)
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ProductTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            ProductTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ProductTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ProductTableView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -10),
            
            shoppingBasketButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            shoppingBasketButton.heightAnchor.constraint(equalToConstant: 35),
        
            exitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            exitButton.heightAnchor.constraint(equalToConstant: 35),
            
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Setup buttons Trigger func
    private func setupButtonstrigger() {
        exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        shoppingBasketButton.addTarget(self, action: #selector(shoppingBasketButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Buttons logic funcs
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func shoppingBasketButtonPressed() {
        let shoppingBasketViewController = ShoppingBasketViewController()
        shoppingBasketViewController.modalPresentationStyle = .fullScreen
        present(shoppingBasketViewController, animated: true)
    }
}

// MARK: - UITabBarDelegate,UITableViewCell implementation
extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = dataSource[indexPath.row]
        cell.configureCell(with: product)
        return cell
    }
}
