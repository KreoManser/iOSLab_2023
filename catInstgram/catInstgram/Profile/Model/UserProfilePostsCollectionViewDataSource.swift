//
//  UserProfilePostsCollectionViewDataSource.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class UserProfilePostsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.syncGetUserPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfilePostCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfilePostCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }

        let post = DataManager.shared.syncGetUserPosts()[indexPath.row]

        cell.configureCell(post.imageName)
        return cell
    }
}
