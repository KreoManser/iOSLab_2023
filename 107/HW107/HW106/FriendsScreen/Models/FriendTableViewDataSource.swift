import Foundation
import UIKit

class FriendTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let friends = CoreDataManager.shared.getFriendsFromCurUser()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseIdentifier, for: indexPath)
        as? FriendTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let user = friends[indexPath.row]
        cell.configure(user: user)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
