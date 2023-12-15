//
//  FollowersDataManager.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import Foundation
import UIKit

class FollowersDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {

//    ProfileDataManager.shared.publicationsUsers

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowersCell.reuseIdentifier, for: indexPath)
        as? FollowersCell
        cell?.configFollower(withFollower: followers[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    private let followers: [Follower] = [
        Follower(id: UUID(), avatar: UIImage.badcat1, userName: "BadCat", status: "Подписан"),
        Follower(id: UUID(), avatar: UIImage.kot3, userName: "Славный_Котик", status: "Подписан"),
        Follower(id: UUID(), avatar: UIImage.k1, userName: "Kitty", status: "Подписан")
    ]
}
