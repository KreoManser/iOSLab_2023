//
//  CollectionViewDataSource.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.syncGetAllPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoViewCell.reuseIdentifier,
            for: indexPath) as? PhotoViewCell

        let post = DataManager.shared.syncGetAllPosts()[indexPath.row]

        cell?.configureCell(post.imageName)
        return cell!
    }
}
