//
//  DetailPostView.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

class DetailPostView: UIView, UITableViewDelegate {
    // MARK: - Declaration objects
    weak var controller: DetailPostViewController?

    private lazy var searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.barTintColor = .white
        searchbar.searchBarStyle = .minimal
        searchbar.placeholder = "Введите описание поста"
        searchbar.backgroundColor = .white
        searchbar.delegate = self
        searchbar.delegate = self
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()
    lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.reuseIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 560
        return table
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Search Bar Funcs
extension DetailPostView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let controller = controller else { return }
        controller.searchPostsByName(searchText)

        guard let text = searchBar.text else { return }

        if text.isEmpty {
            PostsManager.postsManager.isSearching = false
        } else {
            PostsManager.postsManager.isSearching = true
        }

        reloadData()
    }
}

// MARK: - Custom DetailPostAlertDelegate
extension DetailPostView: DetailPostAlertDelegate {
    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить котикса", message: "Удалить котика :(?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
            self?.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Не надо..", style: .cancel))
        controller?.present(alert)
    }
}

extension DetailPostView: LikePostDelegate {
    func likePost(indexPath: IndexPath) {
        self.controller?.like(indexPath: indexPath)
        self.reloadData()
    }
}

// MARK: - Table Info with system methods
extension DetailPostView {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Table Info with personal metiods
extension DetailPostView {
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        postsTableView.dataSource = dataSource
    }
    func reloadData() {
        self.postsTableView.reloadData()
    }
    func scrollTo(_ postIndex: IndexPath) {
        postsTableView.scrollToRow(at: postIndex, at: .top, animated: true)
    }
}

// MARK: - ObjC
extension DetailPostView {
    func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))

        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            controller?.dismissScreen()
        }
    }
}

// MARK: - Constraints
extension DetailPostView {
    private func setupLayouts() {
        addSubview(searchBar)
        addSubview(postsTableView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 30),

            postsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
