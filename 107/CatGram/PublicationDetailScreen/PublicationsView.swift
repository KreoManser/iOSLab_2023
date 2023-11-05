//
//  PublicationsView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 31.10.2023.
//

import UIKit

class PublicationsView: UIView {

    lazy var tableView: UITableView = {
        let subView = UITableView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    lazy var searchBar: UISearchBar = {
        let subView = UISearchBar()
        subView.placeholder = "Search Posts"
        subView.searchBarStyle = .prominent
        subView.showsCancelButton = true
        subView.backgroundColor = .white
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(tableView)
        setUpTabeleViewLayout()
        addSubview(searchBar)
        setUpSearchBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpTabeleViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    private func setUpSearchBar() {
        searchBar.becomeFirstResponder()
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
