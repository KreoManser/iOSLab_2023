import Foundation
import UIKit

class PostTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.syncGetPosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
        as? PostTableViewCell
        let post = DataManager.shared.syncGetPosts()[indexPath.row]

        cell?.delegate = tableView.superview as? any PostTableAlertDelegate
        cell?.superView = tableView
        cell?.configureCell(post)

        return cell!
    }
}
