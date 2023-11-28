//
//  DetailViewController.swift
//  CaTGramm
//
//  Created by Rustem on 30.10.2023.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            fatalError("Failed to dequeue Cell in View")
        }
        cell.configureCell(datasource[indexPath.row])
        cell.delegate = self
        return cell
    }

    lazy var previousController = ViewController.shared

    lazy var datasource = DataManager.OurDataManager.syncGetCurrentUserPosts()

    func reloadData() {
        tableView.reloadData()
    }

    let navLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "мой ник\nпубликации"
        return label
    }()

    init(controller: ViewController) {
        super.init(nibName: nil, bundle: nil)
        previousController = controller
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        navigationItem.titleView = navLabel
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension DetailViewController: PostTableAlertDelegate {

    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить пост", message: "Вы действительно хотите удалить этот пост?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            DataManager.OurDataManager.syncDeleteModel((self?.datasource[indexPath.row]) ?? (DataManager.OurDataManager.syncGetCurrentUserPosts()[0]))
            self?.datasource = DataManager.OurDataManager.syncGetCurrentUserPosts()
            self?.reloadData()
            self?.previousController.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
}
