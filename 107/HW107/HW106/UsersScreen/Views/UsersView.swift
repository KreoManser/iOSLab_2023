import UIKit

class UsersView: UIView {
    private lazy var usersPageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "All users"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UsersView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(usersPageNameLabel)
        addSubview(usersTableView)

        NSLayoutConstraint.activate([
            usersPageNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            usersPageNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            usersTableView.topAnchor.constraint(equalTo: usersPageNameLabel.bottomAnchor, constant: 15),
            usersTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        usersTableView.dataSource = dataSource
    }

    func reloadData() {
        usersTableView.reloadData()
    }
}
