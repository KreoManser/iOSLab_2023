//
//  TimelineDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import Foundation
import UIKit

class TimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManagerPublication: DataManagerPublication = DataManagerPublication.shared
    var dataManagerUser: DataManagerUser = DataManagerUser.shared
    var historyDataSource = HistoryDataSource()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManagerPublication.syncGetSubsriptionPublication().count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let with = HistoryTimelineCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: with, for: indexPath) as? HistoryTimelineCollectionViewCell
            if let cell = cell {
                cell.configureCell(historyDataSource)
                return cell
            }
            return UICollectionViewCell()
        } else {
            let withReuseIdentifier = TimelineCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? TimelineCollectionViewCell

            if let cell = cell {
                let publication = dataManagerPublication.syncGetSubsriptionPublication()[indexPath.row]
                if let user = dataManagerUser.syncSearch(by: publication.userId) {
                    cell.setupUser(user: user)
                }
                cell.configureCell(publication: publication)
                return cell
            }
            return UICollectionViewCell()
        }
    }
}
