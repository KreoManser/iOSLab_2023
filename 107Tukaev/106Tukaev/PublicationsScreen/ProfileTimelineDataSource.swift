//
//  TableCellDataSource.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import Foundation
import UIKit

class ProfileTimelineDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManager = CoreDataManager.shared
    let user: User

    init(user: User) {
        self.user = user
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.getUserPubl(user: user).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let withIdentificator = TimelineCollectionViewCell.reuseIdentificator
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withIdentificator, for: indexPath) as? TimelineCollectionViewCell
        if let cell = cell {
            if user == dataManager.authUser {
                cell.delegate = collectionView.superview as? any AlertDelegate
            }
            let user = self.user
            let publication = dataManager.getUserPubl(user: user)[indexPath.row]
            cell.setupUser(user: user)
            let likePressed = self.dataManager.likeTap(publ: publication)
            cell.setLikes(likes: publication.likes.count)
            cell.pressedLikeBtn(like: likePressed)
            cell.doubleTap = {
                let like = self.dataManager.addLike(publ: publication)
                cell.pressedLikeBtn(like: !like)
                let updPublication = self.dataManager.getUserPubl(user: user)[indexPath.row]
                cell.setLikes(likes: updPublication.likes.count)
            }
            cell.configureCell(publication: publication)
            return cell
        }
        return UICollectionViewCell()
    }
}

