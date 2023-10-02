import UIKit

class ViewController: UIViewController, UITableViewDelegate {
        
    enum TableSection {
            case main
        }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        table.rowHeight = 100
        return table
    }()
    
    var tasks = [Task] ()
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTasksData()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupLayout()
        setupDataSource()
        setupNavigationBar()
        
    }

    func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
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
            let task = Task(id: UUID(), title: "New Task", description: "Description")
            snapshot.appendItems([task], toSection: .main)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "Tasks"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)

    }

    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in

            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.configureCell(task: task)
            return cell
        })
        updateDataSource(with: tasks, animate: false)
    }
    
    func initTasksData () {
        tasks = [
            Task(id: UUID(), title: "Task1", description: "description1"),
            Task(id: UUID(), title: "Task2", description: "description2"),
            Task(id: UUID(), title: "Task3", description: "description3"),
            Task(id: UUID(), title: "Task4", description: "description4"),
            Task(id: UUID(), title: "Task5", description: "description5"),

        ]
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

extension ViewController: TaskDetailDelegate {
    func saveData(task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}
extension ViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = TaskDetailViewController(task: task, delegate: self)

            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
