//
//  TableViewDataSource.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 29.10.2023.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell

        var post: Post

        if DataManager.shared.isSearching == false {
            post = DataManager.shared.syncGetAllPosts()[indexPath.row]
        } else {
            post = DataManager.shared.syncGetSearchedPosts()[indexPath.row]
        }

        guard let cell = cell else { return UITableViewCell() }

        cell.delegate = tableView.superview as? any PostTableAlertDelegate
        cell.superView = tableView
        cell.configureCell(post)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.isSearching == false {
            return DataManager.shared.syncGetAllPosts().count
        } else {
            return DataManager.shared.filteredPostsCount
        }
    }
}
