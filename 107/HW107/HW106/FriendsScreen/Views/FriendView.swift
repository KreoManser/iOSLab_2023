import UIKit

class FriendView: UIView {
    private lazy var friendsPageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var friendsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    weak var friendViewController: FriendViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FriendView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(friendsPageNameLabel)
        addSubview(friendsTableView)

        NSLayoutConstraint.activate([
            friendsPageNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            friendsPageNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            friendsTableView.topAnchor.constraint(equalTo: friendsPageNameLabel.bottomAnchor, constant: 15),
            friendsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))

        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            friendViewController?.dismiss(animated: true)
        }
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        friendsTableView.dataSource = dataSource
    }

    func reloadData() {
        friendsTableView.reloadData()
    }
}
