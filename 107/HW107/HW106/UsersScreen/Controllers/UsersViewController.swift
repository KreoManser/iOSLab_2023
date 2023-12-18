import UIKit

class UsersViewController: UIViewController {
    private let usersView = UsersView(frame: .zero)
    private let usersDataSource = UsersTableViewDataSource()

    override func loadView() {
        view = usersView
        usersDataSource.updateTableWithCachedData()
        usersView.setupDataSource(usersDataSource)
    }

    override func viewWillAppear(_ animated: Bool) {
        usersDataSource.updateTableWithCachedData()
    }
}
