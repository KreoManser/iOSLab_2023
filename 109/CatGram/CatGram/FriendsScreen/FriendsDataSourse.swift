//
//  FriendsDataSourse.swift
//  CatGram
//
//  Created by Mac on 2023-12-03.
//

import UIKit

class FriendsDataSourse: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let support = SupportFunctions()

    private var users: [User] = []

    override init() {
        users = support.createDefaultUsers()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendTableViewCell.reuseIdentifier,
            for: indexPath) as? FriendTableViewCell
        else { return UITableViewCell()}

        cell.configure(with: users[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
