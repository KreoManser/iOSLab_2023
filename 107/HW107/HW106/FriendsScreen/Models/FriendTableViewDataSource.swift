import Foundation
import UIKit

class FriendTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LoginDataManager.loginShared.getCountOfFriends()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reuseIdentifier, for: indexPath)
        as? FriendTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let user = LoginDataManager.loginShared.getFriends()[indexPath.row]
        cell.configure(user: user)
        return cell
    }
}
