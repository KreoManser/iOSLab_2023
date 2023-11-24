//
//  FriendsDataManager.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import Foundation
import UIKit

class FriendsDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var users: [User] = [
        User(id: UUID(), login: "Pushinka.52NGG", password: "123", avatarImage: UIImage(named: "logoImage")),
        User(id: UUID(), login: "Admin", password: "admin", avatarImage: UIImage(named: "adminLogo")),
        User(id: UUID(), login: "dogLover", password: "dogLover", avatarImage: UIImage(named: "dogLogo"))
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifier,
            for: indexPath) as? FriendsTableViewCell
        else { return UITableViewCell()}

        cell.configure(with: users[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
