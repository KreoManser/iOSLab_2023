//
//  FriendDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 10.12.2023.
//

import Foundation
import UIKit

class FriendDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    static let shared = FriendDataManager()
    var coreDataManager =  CoreDataManager.shared
    var userDataManager =  UserDataManager.shared
    var feedDataManager = FeedDataManager.shared
    var usersFriends: [Friend] = []

    override init() {
        super.init()
        addFriendToUser("user1")
    }

    private func addFriendToUser(_ username: String) {
        print("retrieving context and user")
        let viewContext = coreDataManager.viewContext
        guard let currentUser = feedDataManager.currentUser
        else {
            print("error while retrieving view context and user")
            return
        }

        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let friendOfUser = users.first {
                let friend = Friend(context: viewContext)
                friend.user = currentUser
                friend.friendshipStatus = "friends"
                friendOfUser.addToFriends(friend)
             //   currentUser.addToFriends(friend)
                usersFriends.append(friend)

                try viewContext.save()
            } else {
                print("user with username user1 not found")
            }
        } catch {
            print("error while trying to fetch user \(error)")
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersFriends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifierforTableView,
            for: indexPath) as? FriendsTableViewCell else {
            return UITableViewCell() }
        cell.configureCell(with: usersFriends[indexPath.row])
        return cell
    }
}
