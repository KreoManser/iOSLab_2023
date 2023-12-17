import Foundation
import UIKit

class MainPostsTableViewDataSource: NSObject, UITableViewDataSource {
    private let posts = CoreDataManager.shared.getAllPostForCurUserFriends()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
        as? PostTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.configureMainScreenPostCell(post)
        return cell
    }
}
