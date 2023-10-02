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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier1")

        tableView.separatorStyle = .none
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: StoreTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .purple
        return tableView
    }()
    
    var stores: [Store] = []
    var dataSourse: UITableViewDiffableDataSource<Int, Store>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        for i in 1...5 {
            stores.append(Store( image: UIImage(named: "StoreIcons"), title: "Товар: \(i)", subTitle: "набор путешественника", creator: "*travel provider*"))
        }
    
      
        view.addSubview(tableView)
        setupNavigationBar()
        setupDataSourse()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    
    }
    func setupDataSourse(){
        dataSourse = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, store in
            
            let cell = tableView.dequeueReusableCell( withIdentifier: StoreTableViewCell.reuseIdentifier, for: indexPath) as! StoreTableViewCell
            cell.configerCell(with: store)
            return cell
        })
        
        
        updateDataSorce(with: stores, animate: true)
    }
    
    func updateDataSorce(with stores: [Store], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Store>()
        snapshot.appendSections([0])
        snapshot.appendItems(stores)
        dataSourse?.apply(snapshot, animatingDifferences: animate)
    }
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
        }
        let addAction = UIAction { _ in
            self.stores.append(Store( image: UIImage(named: "StoreIcons"), title: "Товар: 666", subTitle: "набор путешественника", creator: "*travel provider*"))
        }
        
        navigationItem.title = "Store"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let store = stores[sourceIndexPath.row]
        stores.remove(at: sourceIndexPath.row)
        stores.insert(store, at: destinationIndexPath.row)
        
        tableView.reloadRows(at: [sourceIndexPath , destinationIndexPath], with: .top)
    }
}

extension StoreViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return stores.count
//    }
//    
}

