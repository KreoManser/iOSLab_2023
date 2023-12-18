//
//  FriendsDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation
import UIKit

class FriendsDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var coreDataManager = CoreDataManager.shared
    private var fetchedResultController = CoreDataManager.shared.createFriendsFetchResultController()

    override init() {
        super.init()
        self.updateTableWithCachedData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifier,
            for: indexPath) as? FriendsTableViewCell
        else { return UITableViewCell()}

        let friend = fetchedResultController.object(at: indexPath)

        cell.subscribeFriend = { [weak self] user in
            self?.coreDataManager.addNewFriend(friend: user)
            cell.toggleSubsribition()
        }

        cell.unSubscribeFriend = { [weak self] user in
            self?.coreDataManager.removeFriend(friend: user)
            cell.toggleSubsribition()
        }

        cell.configure(with: friend.friend, isSubscribed: isSubscribedForUser(user: friend.friend))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("fetch request failed with error: \(error)")
        }
    }

    func isSubscribedForUser(user: User) -> Bool {
        return coreDataManager.isFriendForAuthUser(friend: user)
    }
}
