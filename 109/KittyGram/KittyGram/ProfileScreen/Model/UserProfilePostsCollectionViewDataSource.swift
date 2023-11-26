//
//  UserProfilePostsTableViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation
import UIKit

class UserProfilePostsCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private let dataManager = DataManager.shared

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.syncGetUserPosts().count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfilePostCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfilePostCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }

        let post = dataManager.syncGetUserPosts()[indexPath.row]

        cell.configureCell(post.imageName)
        return cell
    }
}
