//
//  UserProfilePostsView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class UserProfilePostsView: UIView {
    // MARK: - UI elements
    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.barTintColor = .black
        searchbar.placeholder = "Поиск"
        searchbar.backgroundColor = .white
        searchbar.delegate = self
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()

    lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self,
        forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
        return tableView
    }()

    // MARK: - Variables
    weak var controller: UserProfilePostsViewController?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        addSubviews(subviews: searchBar, postTableView)
        configureUI()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserProfilePostsView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        postTableView.dataSource = dataSource
    }

    func reloadData() {
        postTableView.reloadData()
    }

    func scrollToIndexPath(_ indexPath: IndexPath) {
        postTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            postTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            postTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UserProfilePostsView: PostTableAlertDelegate {

    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Удалить пост",
            message: "Вы действительно хотите удалить этот пост?",
            preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
            self?.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        controller?.present(alert)
    }

    func setupGestures() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            controller?.dismissScreen()
        }
    }

    @objc func handleTap() {
        self.endEditing(true)
    }
}

extension UserProfilePostsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let controller = controller else { return }
        controller.searchPostsByName(searchText)

        guard let text = searchBar.text else { return }

        if text.isEmpty {
            DataManager.shared.isSearching = false
        } else {
            DataManager.shared.isSearching = true
        }

        reloadData()
    }
}
