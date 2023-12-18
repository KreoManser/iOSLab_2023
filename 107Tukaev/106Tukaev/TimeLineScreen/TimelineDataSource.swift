//
//  TimelineDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import Foundation
import UIKit
import CoreData

class TimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var dataManager = CoreDataManager.shared
    var historyDataSource = HistoryDataSource()

    override init() {
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            let fetchedResult = dataManager.createFetchedSubPublication()
            return fetchedResult.fetchedObjects?.count ?? 0

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

            let fetchedResult = dataManager.createFetchedSubPublication()

            if let cell = cell {
                cell.pushDelegate = collectionView.superview as? any ProfilePushDelegate
                let publication = fetchedResult.object(at: IndexPath(row: indexPath.row, section: 0))
                cell.delegate = collectionView.superview as? any AlertDelegate
                cell.setupUser(user: publication.user)
                let likePressed = self.dataManager.likeTap(publ: publication)
                cell.setLikes(likes: publication.likes.count)
                cell.pressedLikeBtn(like: likePressed)
                cell.doubleTap = {
                    let like = self.dataManager.addLike(publ: publication)
                    cell.pressedLikeBtn(like: !like)
                    let updPublication = self.dataManager.createFetchedSubPublication().object(at: IndexPath(row: indexPath.row, section: 0))
                    cell.setLikes(likes: updPublication.likes.count)
                }
                cell.configureCell(publication: publication)
            }
            return cell ?? UICollectionViewCell()
        }
    }
}
