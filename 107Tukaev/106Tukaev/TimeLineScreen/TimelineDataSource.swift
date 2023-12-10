//
//  TimelineDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import Foundation
import UIKit

class TimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManager = CoreDataManager.shared
    var historyDataSource = HistoryDataSource()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.getSelfPublSubscription().count
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
                cell.pushDelegate = collectionView.superview as? any ProfilePushDelegate
                let publication = dataManager.getSelfPublSubscription()[indexPath.row]
                cell.delegate = collectionView.superview as? any AlertDelegate
                cell.setupUser(user: publication.user)
                let likePressed = self.dataManager.likeTap(publ: publication)
                cell.setLikes(likes: publication.likes.count)
                cell.pressedLikeBtn(like: likePressed)
                cell.doubleTap = {
                    let like = self.dataManager.addLike(publ: publication)
                    cell.pressedLikeBtn(like: !like)
                    let updPublication = self.dataManager.getUserPubl(user: publication.user)[indexPath.row]
                    cell.setLikes(likes: updPublication.likes.count)
                }

                cell.configureCell(publication: publication)
                return cell
            }
            return UICollectionViewCell()
        }
    }
}
