//
//  ProfileViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 30.10.2023.
//

import Foundation
import UIKit

class ProfileViewDataSource: NSObject, UICollectionViewDataSource {

    var user: User?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let user = self.user else { return 0 }
        var result: Int?

        result = DataManager.shared.syncGetPublications(byUserId: user.id)?.count
        //        Task {
        //            result = await DataManager.shared.asyncGetPublications(byUserId: user.id)?.count
        //        }

        return result ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let user = self.user else { return UICollectionViewCell() }

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        Task {
            let publications = await DataManager.shared.asyncGetPublications(byUserId: user.id) ?? []
            let publication = publications[indexPath.row]
            let image = publication.photo ?? UIImage()
            cell.configureCell(image: image)
        }

        return cell
    }
}
