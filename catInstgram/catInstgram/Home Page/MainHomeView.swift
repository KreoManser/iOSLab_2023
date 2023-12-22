//
//  HomeViewController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class MainHomeView: UIView {

    // MARK: - UI elements
   
    private lazy var usersPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        addSubviews(subviews:  usersPostsTableView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainHomeView {
    func setupTableViewDataSourse(_ dataSource: UITableViewDataSource) {
        usersPostsTableView.dataSource = dataSource
    }

}

extension MainHomeView {

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    private func configureUI() {

        NSLayoutConstraint.activate([
           

            usersPostsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10),
            usersPostsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            usersPostsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            usersPostsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

