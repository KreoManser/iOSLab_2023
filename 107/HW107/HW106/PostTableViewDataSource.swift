import Foundation
import UIKit

class PostTableViewDataSource: NSObject, UITableViewDataSource {
    private let searchedPosts = CoreDataManager.shared.getSearchedPosts()
    let posts = CoreDataManager.shared.getPostsFromCurUser()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.isSearching == false {
            return posts.count
        } else {
            return searchedPosts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
        as? PostTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        var post: Post
        if DataManager.shared.isSearching == false {
            post = posts[indexPath.row]
        } else {
            post = searchedPosts[indexPath.row]
        }
        cell.delegate = tableView.superview as? any PostTableAlertDelegate
        cell.superView = tableView
        cell.configureCell(post)

        return cell
    }
}
