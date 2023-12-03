import UIKit

class FriendsViewController: UIViewController {
    var friendsView = FriendsView()
    var dataManager = FriendsDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    func setUp() {
        view = friendsView
        friendsView.table.delegate = dataManager
        friendsView.table.dataSource = dataManager
        friendsView.table.register( FriendsTableViewCell.self,
                                forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifier)
    }
}
