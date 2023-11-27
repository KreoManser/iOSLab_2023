//
//  NewsViewDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-11-04.
//

import UIKit

class NewsViewDataSourse: NSObject, UITableViewDataSource {
    // MARK: - Declaration objects
    private let manager: NewsManager
    private let currentUser = UserManager.userManager.loginedUser
    private let support = SupportFunctions()

    init(manager: NewsManager) {
        self.manager = manager
    }

    // MARK: - Table Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostViewCell.reuseIdentifier,
            for: indexPath) as? PostViewCell
            else { return UITableViewCell() }

        let post = manager.posts[indexPath.row]
        let isPersonal = post.nick == currentUser?.nick
        cell.configureCell(with: post)
        cell.setAdditionalButton(isPersonalPost: isPersonal)
        cell.backgroundColor = .white
        cell.delegate = tableView.superview as? DetailPostAlertDelegate
        cell.likeDelegate = tableView.superview as? LikePostDelegate
        cell.table = tableView
        return cell
    }
}
