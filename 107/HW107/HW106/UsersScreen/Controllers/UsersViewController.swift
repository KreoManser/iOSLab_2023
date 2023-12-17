import UIKit

class UsersViewController: UIViewController {
    private let usersView = UsersView(frame: .zero)
    private let usersDataSource = UsersTableViewDataSource()

    override func loadView() {
        view = usersView
        usersView.setupDataSource(usersDataSource)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
