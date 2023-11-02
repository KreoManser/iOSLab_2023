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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoViewCell.reuseIdentifier,
            for: indexPath) as? PhotoViewCell
        else { return UICollectionViewCell() }

        let post = DataManager.shared.syncGetAllPosts()[indexPath.row]

        cell.configureCell(post.imageName)
        return cell
    }
}

extension UICollectionView {
    func getItemsCount() -> Int {
        return DataManager.shared.syncGetAllPosts().count
    }
}
