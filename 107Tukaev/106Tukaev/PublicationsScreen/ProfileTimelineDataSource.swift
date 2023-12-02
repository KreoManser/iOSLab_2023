//
//  TableCellDataSource.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import Foundation
import UIKit

class ProfileTimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManagerPublication: DataManagerPublication = DataManagerPublication.shared
    var dataManagerUser: DataManagerUser = DataManagerUser.shared
    let userId: Int

    init(userId: Int) {
        self.userId = userId
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManagerPublication.getPublicationsByUserId(userId: userId).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let withIdentificator = TimelineCollectionViewCell.reuseIdentificator
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withIdentificator, for: indexPath) as? TimelineCollectionViewCell
        if let cell = cell {
            cell.delegate = collectionView.superview as? any AlertDelegate
            let user = dataManagerUser.syncSearch(by: userId) ?? User(0, "login", "", "name", [], 0, 0, 0)
            let publication = dataManagerPublication.getPublicationsByUserId(userId: user.id)[indexPath.row]
            cell.setupUser(user: user)
            let likePressed = self.dataManagerPublication.likeDisplay(id: publication.id, userId: user.id)
            cell.pressedLikeBtn(like: likePressed)
            cell.doubleTap = {
                let like = self.dataManagerPublication.likeDisplay(id: publication.id, userId: user.id)
                cell.pressedLikeBtn(like: !like)

                let countLike = self.dataManagerPublication.addLike(id: publication.id, userId: user.id)
                cell.addLike(likes: countLike)
                self.dataManagerPublication.save()
            }
            cell.configureCell(publication: publication)
            return cell
        }
        return UICollectionViewCell()
    }
}

