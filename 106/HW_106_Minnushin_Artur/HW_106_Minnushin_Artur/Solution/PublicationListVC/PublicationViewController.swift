//
//  ViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 30.10.2023.
//

import UIKit

class PublicationViewController: UIViewController {
    lazy var tableVC: UITableView = {
        let tableVC = UITableView()
        tableVC.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableVC.translatesAutoresizingMaskIntoConstraints = false
        tableVC.delegate = self
        tableVC.dataSource = self
        return tableVC
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableVC)
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableVC.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableVC.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableVC.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PublicationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else { fatalError() }
        
        return cell
    }
    
    
}
