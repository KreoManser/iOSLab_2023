//
//  FriendsDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation
import UIKit

class FriendsDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var friends: [User] = CoreDataManager.shared.getFriendsByUser()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifier,
            for: indexPath) as? FriendsTableViewCell
        else { return UITableViewCell()}

        cell.configure(with: friends[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
