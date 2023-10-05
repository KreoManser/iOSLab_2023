import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    enum SortingCriteria {
        case creationDate
        case none
    }
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
    var sortingCriteria: SortingCriteria = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTasksData()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupLayout()
        setupDataSource()
        setupNavigationBar()
    }
    
    func initTasksData () {
        tasks = [
            Task(id: UUID(), title: "Task2", description: "description2", creationDate: Date(timeIntervalSinceNow: -1800)),
            Task(id: UUID(), title: "Task3", description: "description3", creationDate: Date()),
            Task(id: UUID(), title: "Task1", description: "description1", creationDate: Date(timeIntervalSinceNow: -3600)),
        ]
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.configureCell(task: task)
            return cell
        })
        updateDataSource(with: tasks, animate: false)
    }
    
    func updateDataSource(with tasks: [Task], animate: Bool) {
        sortTasks()
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupNavigationBar() {
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let task = Task(id: UUID(), title: "New Task", description: "Description", creationDate: Date())
            snapshot.appendItems([task], toSection: .main)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "Tasks"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(showSortOptions))
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    @objc func showSortOptions() {
        let alertController = UIAlertController(title: "Выберите критерий сортировки", message: nil, preferredStyle: .actionSheet)
        
        let sortByDateAction = UIAlertAction(title: "По дате создания (сначала новые)", style: .default) { [weak self] _ in
            self?.sortingCriteria = .creationDate
            self?.sortAndReloadhData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(sortByDateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
//    отдельная функция, в которой выполняется сортировка и выбирается sortingCriteria = .none, иначе в методе showSortOptions все подтормаживалось и выполнялось со 2ого раза
    func sortAndReloadhData() {
        sortTasks()
        updateDataSource(with: tasks, animate: true)
        self.sortingCriteria = .none
    }
    
    func sortTasks() {
        switch sortingCriteria {
        case .creationDate:
            tasks.sort(by: { $0.creationDate > $1.creationDate })
        case .none:
            return
        }
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
