//
//  PostsView.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import UIKit

class PostsView: UIView {

    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.searchBarStyle = .minimal
        searchbar.barTintColor = .white
        searchbar.placeholder = "Поиск"
        searchbar.backgroundColor = .white
        searchbar.delegate = self
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()

    lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(PostsTableViewCell.self,
        forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        return tableView
    }()

    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.controller?.dismissScreen()
        }

        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Назад", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var controller: PostsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(subviews: searchBar, postsTableView, exitButton)
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

            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            postsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            exitButton.topAnchor.constraint(equalTo: postsTableView.bottomAnchor, constant: 10),
            exitButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            exitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}

extension PostsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
}

extension PostsView: PostsTableAlertDelegate {
    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
            self?.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        controller?.present(alert)
    }
}

extension PostsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let controller = controller else { return }
        controller.searchPostsByDescription(searchText)
        guard let text = searchBar.text else { return }

        if text.isEmpty {
            DataManager.shared.isSearching = false
        } else {
            DataManager.shared.isSearching = true
        }

        reloadData()
    }
}
