//
//  UserStoriesCollectionViewDataSource.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class UserStoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return DataManager.shared.syncGetUserSubscription().count + 1

        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UserStoriesCollectionViewCell.reuseIdentifier,
            for: indexPath) as? UserStoriesCollectionViewCell

            guard let cell = cell else { return UICollectionViewCell() }

            if indexPath.row == 0 {

                cell.configureCellForCurrentUser()
                return cell

            } else {

                cell.configureCell(with: DataManager.shared.syncGetUserSubscription()[indexPath.row - 1])
                return cell

            }

        }

    }

