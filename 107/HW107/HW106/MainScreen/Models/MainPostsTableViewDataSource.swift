import Foundation
import UIKit

class MainPostsTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.getAllUsersPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
        as? PostTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let post = DataManager.shared.getAllUsersPosts()[indexPath.row]
        cell.configureMainScreenPostCell(post)
        return cell
    }
}
