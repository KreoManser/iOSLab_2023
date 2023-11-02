//
//  PublishersView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 01.11.2023.
//

import UIKit
class PublishersView: UIView {
    weak var controller: PublisherViewController?
    var publishers: [Publisher] = []
    var array = DataManager.publishers
    lazy var tablePublisher: UITableView =  {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(PublisherTableViewCell.self, forCellReuseIdentifier: "Publisher")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(tablePublisher)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadData() {
        DataManager.getPublishers { [weak self] publishers in
            DispatchQueue.main.async {
                self?.publishers = publishers
            }
        }
        tablePublisher.reloadData()
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tablePublisher.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tablePublisher.leadingAnchor.constraint(equalTo: leadingAnchor),
            tablePublisher.trailingAnchor.constraint(equalTo: trailingAnchor),
            tablePublisher.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
extension PublishersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tablePublisher.dequeueReusableCell(
            withIdentifier: "Publisher", for: indexPath
        ) as? PublisherTableViewCell {
            let publisher = publishers[indexPath.row]
            cell.configure(with: publisher)
            cell.delegate = self.controller
            cell.currentPublisher = publisher
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension PublishersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 730
    }
}
