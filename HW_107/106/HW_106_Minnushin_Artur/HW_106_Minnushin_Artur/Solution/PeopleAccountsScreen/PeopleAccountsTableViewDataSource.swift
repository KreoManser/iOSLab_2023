//
//  PeopleAccountsTableViewDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 21.12.2023.
//

import UIKit
import CoreData

class PeopleAccountsTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    let coreDataManager = CoreDataManager.shared
    var fetchedResultController: NSFetchedResultsController<User>!
    init(controller: NSFetchedResultsController<User>) {
        self.fetchedResultController = controller
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "peopleAccountCell",
            for: indexPath) as? PeopleAccountsTableViewCell else { return UITableViewCell() }
        let item = fetchedResultController.object(at: indexPath)
        cell.userAvatarImageView.image = UIImage(named: item.userAvatarImageName)
        cell.userNameLabel.text = item.userName
        cell.subscribeCheker = coreDataManager.checkFriended(userId: Int(item.userId))
        cell.userId = Int(item.userId)
        cell.setupButton()
        cell.delegate = tableView.superview as? any PeopleAccountsProtocols
        return cell
    }
}
