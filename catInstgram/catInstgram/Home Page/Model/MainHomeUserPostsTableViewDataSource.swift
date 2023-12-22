//
//  MainFeedUserPostsTableViewDataSource.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class MainHomeUserPostsTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.synGetUserSubscriptionPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell

        guard let cell = cell else { return UITableViewCell() }

        let post = DataManager.shared.syncGetUserSubscriptionPostsWithUser()[indexPath.row]

        cell.configureCellForMainFeed(post: post.1, userName: post.0.username, avatar: post.0.avatar)

        return cell
    }

}
