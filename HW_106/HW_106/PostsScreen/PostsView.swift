//
//  PostsView.swift
//  HW_106
//
//  Created by Азат Зиганшин on 31.10.2023.
//

import UIKit

class PostsView: UIView {

    lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(PostsTableViewCell.self,
        forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        return tableView
    }()

    var controller: PostsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsView: UITableViewDelegate, DeleteAlertDelegate {

    func presentDeleteAlert(_ indexPath: IndexPath) {
        controller?.presentAlert(indexPath)
    }

    func reloadData() {
        postTableView.reloadData()
    }

    func scrollToIndexPath(_ indexPath: IndexPath) {
        postTableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }

    func setupDataSourse(_ dataSource: UITableViewDataSource) {
        postTableView.dataSource = dataSource
    }

    func setupLayout() {

        addSubview(postTableView)

        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
