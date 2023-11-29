import UIKit

class FriendViewController: UIViewController {
    private let friendView = FriendView(frame: .zero)
    private let friendsDataSource = FriendTableViewDataSource()

    override func loadView() {
        view = friendView
        friendView.setupDataSource(friendsDataSource)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        friendView.friendViewController = self
    }
}
