//
//  FeedCollectionViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

class FeedCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result = UserDataManager.shared.syncGetAllUsers().count
        return result
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        let users = UserDataManager.shared.syncGetAllUsers()
        cell.configureCell(users[indexPath.row])

        return cell
    }
}
