//
//  FeedPostsTableViewDataSource.swift
//  HW_106
//
//  Created by Азат Зиганшин on 06.11.2023.
//

import Foundation
import UIKit

class FeedPostsTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataManager.shared.syncGetAllPublications().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostsTableViewCell.reuseIdentifier,
            for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.delegate = tableView.superview as? any DeleteAlertDelegate

        let publication = DataManager.shared.syncGetAllPublications()[indexPath.row]
        guard let postUser = UserDataManager.shared.syncGetUser(byId: publication.userId) else { return UITableViewCell() }
        cell.configureCell(with: publication, postUser)

        return cell
    }
}
