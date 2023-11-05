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

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }

        DataManager.shared.asyncGetAllPublications(completion: {publications in
            let publication = publications[indexPath.row]
            let image = publication.photo
            cell.configureCell(image: image)
        })

        return cell
    }
}
