//
//  DetailPostViewDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class DetailPostViewDataSourse: NSObject, UITableViewDataSource {
    // MARK: - Declaration objects
    private let manager = DataManager.dataManager

    // MARK: - Table Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.dataManager.isSearching == false {
            return manager.getPostsSync().count
        } else {
            return manager.postWithFilter.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailPostTableViewCell.reuseIdentifier,
            for: indexPath) as? DetailPostTableViewCell
            else { return UITableViewCell() }

        let post: Post
        if manager.isSearching == false {
            post = manager.getPostsSync()[indexPath.row]
        } else if indexPath.row < manager.postWithFilter.count {
            post = manager.postWithFilter[indexPath.row]
        } else {
            post = Post(id: 0,
            author: User(iconUrl: nil, nick: "nick"),
            photos: UIImage(),
            dateOfPublication: Date.now,
            comments: [], amountOfLikes: 0,
            description: "")
        }

        cell.configureCell(with: post)
        cell.backgroundColor = .white
        cell.delegate = tableView.superview as? DetailPostAlertDelegate
        cell.table = tableView
        return cell
    }
}
