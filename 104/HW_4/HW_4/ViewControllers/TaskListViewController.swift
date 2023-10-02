import UIKit

class TaskListViewController: UIViewController {
    enum TableSection {
        case main
    }

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.rowHeight = 80
        
        return table
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1 ..< 10 {
            tasks.append(Task(id: UUID(), name: "Task \(i)", description: "iIYDEEVDEUVUDV DVUEVEDVUUE DVEDEYTVDEYDEYDVYEEVD", dateOfAdd: Date()))
        }
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(task: task)
            
            return cell
        })
        
        updateDataSource(with: tasks, animate: false)
    }
    
    func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
        }
        
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            
            let task = Task(id: UUID(), name: "New Task", description: "dufgdubdudvbdvdvd djfvdjfvdjd", dateOfAdd: Date())
            
            snapshot.appendItems([task], toSection: .main)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "Tasks List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
}

extension TaskListViewController: TaskDetailControllerDelegate {
    func dataUpdated(for task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let taskDetailController = TaskDetailViewController(with: task, delegate: self)

            navigationController?.pushViewController(taskDetailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let task = dataSource?.itemIdentifier(for: indexPath) {
                tasks.removeAll(where: { $0.id == task.id })
                updateDataSource(with: tasks, animate: true)
            }
        }
    }
}
