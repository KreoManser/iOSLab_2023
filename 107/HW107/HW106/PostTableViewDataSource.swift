import Foundation
import UIKit

class PostTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.isSearching == false {
            return DataManager.shared.syncGetPosts().count
        } else {
            return DataManager.shared.getSearchedPosts().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
        as? PostTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        var post: Post
        if DataManager.shared.isSearching == false {
            post = DataManager.shared.syncGetPosts()[indexPath.row]
        } else {
            post = DataManager.shared.getSearchedPosts()[indexPath.row]
        }

        cell.delegate = tableView.superview as? any PostTableAlertDelegate
        cell.superView = tableView
        cell.configureCell(post, isLiked: DataManager.shared.checkIfLikedPost(post: post))

        return cell
    }
}
