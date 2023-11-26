//
//  MainFeedUserPostsTableViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation
import UIKit

class MainFeedUserPostsTableViewDataSource: NSObject, UITableViewDataSource {

    private let dataManager = DataManager.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.synGetUserSubscriptionPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: indexPath) as? PostTableViewCell

        guard let cell = cell else { return UITableViewCell() }

        cell.observer = DataManager.shared
        let post = dataManager.syncGetUserSubscriptionPostsWithUser()[indexPath.row]
        guard let isLiked = dataManager.currentUser?.likedPostsId.contains(post.1.id) else { return UITableViewCell() }
        cell.configureCellForMainFeed(
            post: post.1,
            userName: post.0.nickname,
            avatar: post.0.avatar,
            isLiked: isLiked)

        return cell
    }

}
