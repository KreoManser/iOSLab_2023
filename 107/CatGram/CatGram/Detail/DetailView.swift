//
//  DetailTableView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import UIKit

class DetailView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var indexPath: IndexPath

    required init(frame: CGRect, indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(frame: frame)
        backgroundColor = .white
        setUpTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
