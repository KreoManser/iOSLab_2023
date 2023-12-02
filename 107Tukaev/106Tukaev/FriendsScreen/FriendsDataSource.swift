//
//  FriendsDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 30.11.2023.
//

import Foundation
import UIKit

class FriendsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var dataManagerPublication: DataManagerPublication = DataManagerPublication.shared
    var dataManagerUser: DataManagerUser = DataManagerUser.shared

    private let userId: Int

    init(userId: Int) {
        self.userId = userId
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManagerPublication.getPublicationsByUserId(userId: userId).count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let withReuseIdentifier = ProfileCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? ProfileCollectionViewCell

            if let cell = cell {
                let user = dataManagerUser.syncSearch(by: userId) ?? User(0, "login", "", "name", [], 0, 0, 0)
                cell.configureCell(with: user, selfUser: dataManagerPublication.selfUser(user: user))
                return cell
            }
            return UICollectionViewCell()

        } else {

            let withReuseIdentifier = PublicationCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? PublicationCollectionViewCell

            if let cell = cell {
                cell.configureCell(with: dataManagerPublication.getPublicationsByUserId(userId: userId)[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
