//
//  UserProfilePostsTableViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation
import UIKit

class UserProfilePostsTableViewDataSource: NSObject, UITableViewDataSource {

    private let dataManager = DataManager.shared

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: indexPath) as? PostTableViewCell

        var post: Post

        if dataManager.isSearching == false {
            post = dataManager.syncGetUserPosts()[indexPath.row]
        } else {
            post = dataManager.syncGetSearchedPosts()[indexPath.row]
        }

        guard let cell = cell else { return UITableViewCell() }
        cell.delegate = tableView.superview as? any PostTableAlertDelegate
        cell.observer = DataManager.shared
        cell.superView = tableView

        guard let currentUser = dataManager.currentUser else { return PostTableViewCell() }
        guard let isLiked = dataManager.currentUser?.likedPostsId.contains(post.id) else { return UITableViewCell() }
        cell.configureCell(
            post: post,
            userName: currentUser.nickname,
            avatar: currentUser.avatar,
            isLiked: isLiked,
            configureFor: .profile)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if dataManager.isSearching == false {
            return dataManager.syncGetUserPosts().count
        } else {
            return dataManager.filteredPostsCount
        }
    }
}
