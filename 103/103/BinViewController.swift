//
//  File.swift
//  103
//
//  Created by Dmitry on 24.09.2023.
//

import UIKit

class BinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(BinPageTableCell.self, forCellReuseIdentifier: BinPageTableCell.reuseIdentifire)
        return table
    }()
    
    var dataSource = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = Array(repeating: User(name: "Big", surname: "Cock"), count: 30)
        
        view.backgroundColor = .white
        title = "Удаленные контакты"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        setUpTableViewConstraints()
    }
    
    
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BinPageTableCell.reuseIdentifire, for: indexPath) as! BinPageTableCell
        
        let user = dataSource[indexPath.row]
        
        cell.configureCell(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

}

extension UITableViewCell {
    static var reuseIdentifire: String {
        return String(describing: self)
    }
}
