//
//  FeedViewDataSoure.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class FeedTableViewDataSoure: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = DataManager.shared.syncGetPostsWithoutCurrentUserPosts().count
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.reuseIdentifier, for: indexPath) as? PostsTableViewCell
        else { return UITableViewCell() }
        let post = DataManager.shared.syncGetUserAndPostsWithoutCurrentUser()[indexPath.row]
        cell.configureCellForMainFeed(post: post.1, userName: post.0.login, avatar: post.0.avatar)

        return cell
    }
}
