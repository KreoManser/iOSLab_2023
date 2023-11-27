//
//  DetailPostViewDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class DetailPostViewDataSourse: NSObject, UITableViewDataSource {
    // MARK: - Declaration objects
    private let manager = PostsManager.postsManager
    private let support = SupportFunctions()

    // MARK: - Table Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PostsManager.postsManager.isSearching == false {
            return manager.getPostsSync().count
        } else {
            return manager.postWithFilter.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.reuseIdentifier,
            for: indexPath) as? PostViewCell
            else { return UITableViewCell() }

        let post: Post
        if manager.isSearching == false {
            post = manager.getPostsSync()[indexPath.row]
        } else if indexPath.row < manager.postWithFilter.count {
            post = manager.postWithFilter[indexPath.row]
        } else {
            return UITableViewCell()
        }
        cell.configureCell(with: post)
        cell.backgroundColor = .white
        cell.delegate = tableView.superview as? DetailPostAlertDelegate
        cell.likeDelegate = tableView.superview as? LikePostDelegate
        cell.table = tableView
        return cell
    }
}
