//
//  StoriesDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-11-06.
//

import UIKit

class StoriesDataSourse {
    private var dataSourse: UICollectionViewDiffableDataSource<CollectionSection, Story>?

    func setupDataSourse(_ postsCollectionView: UICollectionView) {
        dataSourse = UICollectionViewDiffableDataSource(collectionView: postsCollectionView, cellProvider: { collectionView, indexPath, story in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryViewCell.reuseIdentifier, for: indexPath)
                as? StoryViewCell

            cell?.configureCell(with: story)
            return cell
        })
    }
    func updateDataSourse(with stories: [Story]) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, Story>()
        snapshot.appendSections([.story])
        snapshot.appendItems(stories)
        dataSourse?.apply(snapshot)
    }
}
