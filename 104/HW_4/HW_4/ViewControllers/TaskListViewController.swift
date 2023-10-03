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
            tasks.append(Task(name: "Task \(i)", description: "iIYDEEVDEUVUDV DVUEVEDVUUE DVEDEYTVDEYDEYDVYEEVD", dateOfAdd: Date(), priority: .medium))
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
        let addAction = UIAction { _ in
            self.navigationController?.pushViewController(NewTaskViewController(delegate: self), animated: true)
        }
        
        navigationItem.title = "Tasks List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .compose, menu: setupSortingButtom())
        navigationItem.leftBarButtonItem?.changesSelectionAsPrimaryAction = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func setupSortingButtom() -> UIMenu {
        let sortingByEarlierTasks = UIAction(title: "Earlier task") { _ in
            self.tasks.sort { $0.dateOfAdd < $1.dateOfAdd }
            self.updateDataSource(with: self.tasks, animate: true)
        }
        
        let sortingByLaterTasks = UIAction(title: "Later task") { _ in
            self.tasks.sort { $0.dateOfAdd > $1.dateOfAdd }
            self.updateDataSource(with: self.tasks, animate: true)
        }
        
        let sortingByLowerPriority = UIAction(title: "Lower priority task") { _ in
            self.tasks.sort { $0.priority.rawValue < $1.priority.rawValue }
            self.updateDataSource(with: self.tasks, animate: true)
        }
        
        let sortingByHigherPriority = UIAction(title: "Higher priority task") { _ in
            self.tasks.sort { $0.priority.rawValue > $1.priority.rawValue }
            self.updateDataSource(with: self.tasks, animate: true)
        }
        
        return UIMenu(title: "Sort by", children: [sortingByEarlierTasks, sortingByLaterTasks, sortingByLowerPriority, sortingByHigherPriority])
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

extension TaskListViewController: NewTaskControllerDelegate {
    func addTask(for task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        
        var newTask = task
        if newTask.name == "" {
            newTask.name = "New task"
        }
        
        tasks.append(newTask)
        updateDataSource(with: tasks, animate: false)
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let moveToTrash = UIContextualAction(style: .normal, title: "") { [weak self] _, _, comletionHandler in
            self?.handleMoveToTrash(indexPath: indexPath)
            comletionHandler(false)
        }
        moveToTrash.image = UIImage (systemName: "trash.fill")
        moveToTrash.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [moveToTrash])
    }
    
    func handleMoveToTrash(indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            tasks.removeAll(where: { $0.id == task.id })
            updateDataSource(with: tasks, animate: true)
        }
    }
}
