//
//  TableViewDataSource.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.reuseIdentifier, for: indexPath) as? PostsTableViewCell
        else { return UITableViewCell() }

        let post: Post

        if DataManager.shared.isSearching == false {
            post = DataManager.shared.syncGetUserPosts()[indexPath.row]
        } else {
            post = DataManager.shared.syncGetSearchedPosts()[indexPath.row]
        }

        cell.delegate = tableView.superview as? any PostsTableAlertDelegate
        cell.superView = tableView
        cell.configureCellForProfile(
            post: post,
            userName: DataManager.shared.syncGetCurrentUser().login,
            avatar: DataManager.shared.syncGetCurrentUser().avatar)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.isSearching == false {
            return DataManager.shared.syncGetUserPosts().count
        } else {
            return DataManager.shared.searchedPostsCount
        }
    }

    override init() {
        super.init()
    }
}
