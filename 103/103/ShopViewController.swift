//
//  ShopViewController.swift
//  103
//
//  Created by Alina on 24.09.2023.
//

import UIKit

class ShopViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()
    
    var dataSource:[Product] = []
    var tableBottomConstraint: NSLayoutConstraint?
    
    let BackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitle("Выход", for: .normal)
        button.addTarget(AuthorisationViewController.self, action: #selector(BackButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        _ = UIScrollView()
        
        dataSource = Array(repeating: Product(name: "Apple", price: "899$",color: "white", ProductImage: UIImage(named: "apple")), count: 30)
        
        view.addSubview(BackButton)
        view.addSubview(tableView)
        
        setupLayoutConstraints()
        
    }
        
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            BackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            BackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            BackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    

    @objc private func BackButtonTapped(_ Sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        
        let user = dataSource[indexPath.row]
        cell.configureCell(with: user)
        
        return cell
    }
}
