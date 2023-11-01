//
//  ProfileViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 30.10.2023.
//

import Foundation
import UIKit

class ProfileViewDataSource: NSObject, UICollectionViewDataSource {

    static let shared = ProfileViewDataSource()

    private override init() {}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.syncGetAllPublications().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfileCollectionViewCell

        let publication = DataManager.shared.syncGetAllPublications()[indexPath.row]
        let image = publication.photo
        cell?.configureCell(image: image)

        return cell!
    }
}
