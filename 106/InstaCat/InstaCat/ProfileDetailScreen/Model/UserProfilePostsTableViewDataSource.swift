//
//  PostsTableViewdataSource.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 04.11.2023.
//

import Foundation
import UIKit

class UserProfilePostsTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell

        var post: Post

        if DataManager.shared.isSearching == false {
            post = DataManager.shared.syncGetUserPosts()[indexPath.row]
        } else {
            post = DataManager.shared.syncGetSearchedPosts()[indexPath.row]
        }

        guard let cell = cell else { return UITableViewCell() }
        cell.delegate = tableView.superview as? any PostTableAlertDelegate
        cell.superView = tableView
        cell.configureCellForProfile(
            post: post,
            userName: DataManager.shared.syncGetCurrentUser().nickname,
            avatar: DataManager.shared.syncGetCurrentUser().avatar)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if DataManager.shared.isSearching == false {
            return DataManager.shared.syncGetUserPosts().count
        } else {
            return DataManager.shared.filteredPostsCount
        }
    }
}
