import UIKit

class ViewController: UIViewController, UserCellDelegate {
    func didPressDetailDisclosure() {
    }
    
    enum TableSection {
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.separatorStyle = .singleLine
        table.separatorColor = UIColor.black
        table.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)

        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()
    
    var users: [User] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, User>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for i in 0 ..< 7 {
            users.append(User(id: UUID(),
                              name: "Новая заметка \(Int(i))",
                              lastName: "Пусто"))
        }
        tableView.delegate = self
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, user in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
            cell.configureCell(with: user)
            cell.delegate = self
            return cell
        })
        
        updateDataSource(with: users, animate: false)
    }
    
    func updateDataSource(with users: [User], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, User>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { [weak self] _ in
                self?.tableView.isEditing.toggle()
            
            if !(self?.tableView.isEditing ?? false) {
                    self?.tableView.reloadData()
                }
            }
        let addAction = UIAction { _ in
            
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let user = User(id: UUID(),
                            name: "Новая заметка",
                            lastName: "Пока пусто")
            
            snapshot.appendItems([user], toSection: .secondary)
            self.users.append(user)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "Главная"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ViewController: DetailControllerDelegate {
    func dataUpdated(for user: User) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = users.firstIndex(where: { $0.id == user.id }) {
            users.remove(at: objectIndex)
            users.insert(user, at: objectIndex)
            updateDataSource(with: users, animate: false)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = DetailViewController(with: user, delegate: self)
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, completionHandler) in
            // Выполните ваш код удаления здесь
            if let user = self?.dataSource?.itemIdentifier(for: indexPath) {
                if let index = self?.users.firstIndex(where: { $0.id == user.id }) {
                    self?.users.remove(at: index)
                    var snapshot = NSDiffableDataSourceSnapshot<TableSection, User>()
                    snapshot.appendSections([.main, .secondary])
                    snapshot.appendItems(self?.users ?? [])
                    self?.dataSource?.apply(snapshot, animatingDifferences: true)
                }
            }
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
