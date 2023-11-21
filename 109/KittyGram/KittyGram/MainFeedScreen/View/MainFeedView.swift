//
//  MainFeedView.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class MainFeedView: UIView {

    // MARK: - UI elements
    private lazy var userStoriesCollectionView: UICollectionView = {

        let layuot = UICollectionViewFlowLayout()
        layuot.scrollDirection = .horizontal
        layuot.minimumLineSpacing = 0
        layuot.minimumInteritemSpacing = 0
        layuot.itemSize = CGSize(width: 100, height: 120)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UserStoriesCollectionViewCell.self, forCellWithReuseIdentifier: UserStoriesCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var usersPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        addSubviews(subviews: userStoriesCollectionView, usersPostsTableView)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainFeedView {
    func setupTableViewDataSourse(_ dataSource: UITableViewDataSource) {
        usersPostsTableView.dataSource = dataSource
    }

    func setupCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
        userStoriesCollectionView.dataSource = dataSource
    }
}

extension MainFeedView {

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    private func configureUI() {

        NSLayoutConstraint.activate([
            userStoriesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userStoriesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            userStoriesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            userStoriesCollectionView.heightAnchor.constraint(equalToConstant: 120),

            usersPostsTableView.topAnchor.constraint(equalTo: userStoriesCollectionView.bottomAnchor, constant: 10),
            usersPostsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            usersPostsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            usersPostsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
