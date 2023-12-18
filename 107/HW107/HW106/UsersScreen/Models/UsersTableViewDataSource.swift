import Foundation
import UIKit
import CoreData

class UsersTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
//    private let users = CoreDataManager.shared.getAllUsers().filter({ $0.id != CoreDataManager.shared.getCurUser()?.id })
    private var fetchedResultController = CoreDataManager.shared.createUsersFetchResultController()
    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("fetch request failed with error: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath)
        as? UserTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let user = fetchedResultController.object(at: indexPath)
        cell.configure(user: user)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
