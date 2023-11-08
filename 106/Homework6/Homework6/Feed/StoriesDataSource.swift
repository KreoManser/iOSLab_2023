//
//  StoriesDataSource.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class StoriesDataSource: NSObject, UICollectionViewDataSource {
    let stories = DataManager.shared.createStories()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoriesViewCell.reuseIdentifier,
            for: indexPath) as? StoriesViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: stories[indexPath.row])
        return cell
    }
}
