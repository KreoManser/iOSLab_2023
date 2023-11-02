//
//  MainViewDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class MainViewDataSourse {
    private var dataSourse: UICollectionViewDiffableDataSource<CollectionSection, Post>?

    func setupDataSourse(_ postsCollectionView: UICollectionView) {
        dataSourse = UICollectionViewDiffableDataSource(collectionView: postsCollectionView, cellProvider: { collectionView, indexPath, post in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath)
                as? PostCollectionViewCell

            cell?.configureCell(with: post)
            return cell
        })
    }
    func updateDataSourse(with posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSourse?.apply(snapshot)
    }
}
