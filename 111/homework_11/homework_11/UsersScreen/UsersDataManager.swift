//
//  UsersDataManager.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 17.12.2023.
//

import Foundation
import UIKit
import CoreData

class UsersDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var coreDataManager = CoreDataManager.shared

    private var fetchedResultController = CoreDataManager.shared.createUsersFetchResultController()

    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("fetch request failed with error: \(error)")
        }
    }

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
            withIdentifier: UsersTableViewCell.reuseIdentifier,
            for: indexPath) as? UsersTableViewCell
        else { return UITableViewCell()}
        let user = fetchedResultController.object(at: indexPath)

        cell.configure(with: user, isSubscribed: isSubscribedForUser(user: user))
        cell.subscribeFriend = { [weak self] user in
            self?.coreDataManager.addNewFriend(friend: user)
            cell.toggleSubsribition()
        }

        cell.unSubscribeFriend = { [weak self] user in
            self?.coreDataManager.removeFriend(friend: user)
            cell.toggleSubsribition()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func isSubscribedForUser(user: User) -> Bool {
        return coreDataManager.isFriendForAuthUser(friend: user)
    }
}
