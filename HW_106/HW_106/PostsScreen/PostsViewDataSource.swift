//
//  PostsViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 01.11.2023.
//

import Foundation
import UIKit

class PostsViewDataSource: NSObject, UITableViewDataSource {

    var user: User?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user else { return 0 }
        return DataManager.shared.syncGetPublications(byUserId: user.id)?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostsTableViewCell.reuseIdentifier,
            for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.user = user
        cell.delegate = tableView.superview as? any DeleteAlertDelegate

        let publications = DataManager.shared.syncGetPublications(byUserId: user.id)

        guard let publications else { return UITableViewCell() }

        let publication = publications[indexPath.row]

        cell.configureCell(with: publication, user)

        if LikesManager.shared.isLiked(userId: user.id, publicationId: publication.id) {
            cell.likeWithoutAnimation()
        }

        return cell
    }

}

