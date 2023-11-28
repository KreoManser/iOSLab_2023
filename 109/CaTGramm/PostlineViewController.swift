//
//  PostlineViewController.swift
//  CaTGramm
//
//  Created by Rustem on 05.11.2023.
//

import UIKit
class PostlineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            fatalError("Failed to dequeue Cell in View")
        }
        cell.configureCell(datasource[indexPath.row])
        cell.delegate = self
        cell.cellId = indexPath.row
        return cell
    }

    lazy var datasource = DataManager.OurDataManager.syncGetAllPosts()

    func reloadData() {
        tableView.reloadData()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostCell.self,
                           forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension PostlineViewController: PostTableAlertDelegate {

    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить пост", message: "Вы действительно хотите удалить этот пост?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            DataManager.OurDataManager.syncDeleteModel((self?.datasource[indexPath.row]) ?? (DataManager.OurDataManager.syncGetCurrentUserPosts()[0]))
            self?.datasource = DataManager.OurDataManager.syncGetAllPosts()
            self?.reloadData()
            ViewController.shared.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        if self.datasource[indexPath.row].nickname == DataManager.OurDataManager.currentUser.userName {
            self.present(alert, animated: true)
        }
    }
}
