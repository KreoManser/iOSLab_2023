import UIKit

class FriendViewController: UIViewController {
    private let friendView = FriendView(frame: .zero)
    private let friendsDataSource = FriendTableViewDataSource()

    override func loadView() {
        view = friendView
        friendView.setupDataSource(friendsDataSource)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        friendsDataSource.updateTableWithCachedData()
//        friendView.reloadData()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        friendView.friendsViewControllerDismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
