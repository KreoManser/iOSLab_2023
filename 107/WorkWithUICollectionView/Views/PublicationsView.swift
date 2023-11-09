//
//  PublishersView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 01.11.2023.
//

import UIKit
class PublicationsView: UIView {
    weak var controller: PublicationViewController?
    var publications: [Publication] = []
    var cat: User?
    lazy var tablePublication: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(PublicationTableViewCell.self, forCellReuseIdentifier: "Publisher")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(tablePublication)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tablePublication.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tablePublication.leadingAnchor.constraint(equalTo: leadingAnchor),
            tablePublication.trailingAnchor.constraint(equalTo: trailingAnchor),
            tablePublication.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
extension PublicationsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tablePublication.dequeueReusableCell(
            withIdentifier: "Publisher", for: indexPath
        ) as? PublicationTableViewCell {
            let publication = publications[indexPath.row]
            cell.configure(with: publication)
            cell.delegate = self.controller
            cell.currentPublication = publication
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension PublicationsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 730
    }
}
