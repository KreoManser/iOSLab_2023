//
//  PostsView.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import UIKit

class PostsView: UIView {

    lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostsTableViewCell.self,
        forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        return tableView
    }()

    weak var controller: PostsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(subviews: postsTableView)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        postsTableView.dataSource = dataSource
    }

    func reloadData() {
        postsTableView.reloadData()
    }

    func scrollToIndexPath(_ indexPath: IndexPath) {
        postsTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
