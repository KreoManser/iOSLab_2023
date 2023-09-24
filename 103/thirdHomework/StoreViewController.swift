//
//  StoreViewController.swift
//  thirdHomework
//
//  Created by Ruslan on 23.09.2023.
//

import UIKit

class StoreViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier1")
        
        tableView.separatorStyle = .none
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .purple
        return tableView
    }()
    
    var dataSource: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        dataSource = Array.init(repeating: Store( image: UIImage(named: "StoreIcons"), title: "Товар:", subTitle: "набор путешественника", creator: "*travel provider*"), count: 30)
      
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

extension StoreViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.reuseIdentifier, for: indexPath) as! StoreTableViewCell
        
        let store = dataSource[indexPath.row]
        
        
        var cfg = cell.defaultBackgroundConfiguration()
        cfg.cornerRadius = 20
        cfg.customView?.clipsToBounds = true
        cfg.backgroundInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        cfg.backgroundColor = UIColor.orange
        cell.backgroundConfiguration = cfg
        cell.configerCell(with: store)
        return cell
    }
    
}

