//
//  MainFeedUserPostsTableViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import Foundation
import UIKit

class MainFeedUserPostsTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.synGetUserSubscriptionPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell

        guard let cell = cell else { return UITableViewCell() }

        let post = DataManager.shared.syncGetUserSubscriptionPostsWithUser()[indexPath.row]

        cell.configureCellForMainFeed(post: post.1, userName: post.0.nickname, avatar: post.0.avatar)

        return cell
    }

}
