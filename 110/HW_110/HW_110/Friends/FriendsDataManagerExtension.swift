import UIKit
extension FriendsDataManager: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell else {
            return UITableViewCell()
        }
        let user = friendsData[indexPath.row]
        cell.configure(user: user)
        return cell
    }
}
