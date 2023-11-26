//
//  UserStoriesCollectionViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation
import UIKit

class UserStoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private let dataManager = DataManager.shared

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dataManager.syncGetUserSubscription().count + 1

    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: UserStoriesCollectionViewCell.reuseIdentifier,
        for: indexPath) as? UserStoriesCollectionViewCell

        guard let cell = cell else { return UICollectionViewCell() }

        if indexPath.row == 0 {

            cell.configureCellForCurrentUser()
            return cell

        } else {

            cell.configureCell(with: dataManager.syncGetUserSubscription()[indexPath.row - 1])
            return cell

        }

    }

}
