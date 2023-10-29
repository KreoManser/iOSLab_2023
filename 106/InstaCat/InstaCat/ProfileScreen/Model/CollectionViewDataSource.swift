//
//  CollectionViewDataSource.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.syncGetAllPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfilePostCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfilePostCollectionViewCell

        let post = DataManager.shared.syncGetAllPosts()[indexPath.row]

        cell?.configureCell(post.imageName)
        return cell!
    }
}
