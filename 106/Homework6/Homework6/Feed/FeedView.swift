//
//  FeedView.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class FeedView: UIView, UICollectionViewDelegate {
    lazy var storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: 80, height: 80)

        let stories = UICollectionView(frame: .zero, collectionViewLayout: layout)
        stories.translatesAutoresizingMaskIntoConstraints = false
        stories.backgroundColor = .white
        stories.register(StoriesViewCell.self, forCellWithReuseIdentifier: StoriesViewCell.reuseIdentifier)
        stories.showsHorizontalScrollIndicator = false
        return stories
    }()

    private lazy var usersPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews(subviews: storiesCollectionView, usersPostsTableView)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
}

extension FeedView {
    func setupCollectionViewDataSource(_ dataSource: UICollectionViewDataSource) {
        storiesCollectionView.dataSource = dataSource
    }

    func setupTableViewDataSourse(_ dataSource: UITableViewDataSource) {
        usersPostsTableView.dataSource = dataSource
    }
}

extension FeedView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            storiesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 80),

            usersPostsTableView.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor, constant: 10),
            usersPostsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            usersPostsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            usersPostsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
