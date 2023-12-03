//
//  FeedView.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import UIKit

class FeedView: UIView {

    lazy var storyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
        table.showsHorizontalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        return table
    }()

    lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(PostsTableViewCell.self,
        forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        return tableView
    }()

    weak var controller: FeedViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FeedView: UICollectionViewDelegateFlowLayout, UITableViewDelegate, DeleteAlertDelegate {

    func presentDeleteAlert(_ indexPath: IndexPath) {
        controller?.presentAlert(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 110)
    }

    func setupDataSourse(_ collectionDataSource: UICollectionViewDataSource, _ tableDataSource: UITableViewDataSource) {
        storyCollectionView.dataSource = collectionDataSource
        postTableView.dataSource = tableDataSource
    }

    func setupLayout() {

        addSubview(storyCollectionView)
        addSubview(postTableView)

        NSLayoutConstraint.activate([
            storyCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            storyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            storyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            storyCollectionView.heightAnchor.constraint(equalToConstant: 110),

            postTableView.topAnchor.constraint(equalTo: storyCollectionView.bottomAnchor, constant: 5),
            postTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
