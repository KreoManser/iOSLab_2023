//
//  TableCellDataSource.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import Foundation
import UIKit

class ProfileTimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManager: DataManagerPublication = DataManagerPublication.shared

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.syncGetPublicationByUserId().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let withIdentificator = TimelineCollectionViewCell.reuseIdentificator
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withIdentificator, for: indexPath) as? TimelineCollectionViewCell
        if let cell = cell {
            cell.setupUser(user: dataManager.getUser())
            cell.configureCell(publication: dataManager.syncGetPublicationByUserId()[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

