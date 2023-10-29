//
//  PostsView.swift
//  homework_6
//
//  Created by Кирилл Щёлоков on 29.10.2023.
//

import UIKit

class PostsView: UIView {

    lazy var tableView: UITableView = UITableView()
    private var indexPath: IndexPath

    required init(frame: CGRect, indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTableView()
    }

    private func setUpTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
