//
//  PublicationsUIView.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class PublicationsView: UIView, UITableViewDelegate {

    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(PublicationsTableViewCell.self, forCellReuseIdentifier: PublicationsTableViewCell.reuseIdentificator)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var controller: PublicationsViewController?

    private func setupLayout() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }

    func reloadData() {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height * 0.9
    }

    func scroll(_ indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
