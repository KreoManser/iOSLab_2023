import UIKit

class ViewController: UIViewController, UITableViewDelegate, TaskDetailViewControllerDelegate, TableViewCellDelegate {
    
    enum Section {
        case main
    }

    // MARK: Variables
    
    private var filterSortOptions = TaskFilterSortOptions(sortOption: nil)
    
    private var dataSource: UITableViewDiffableDataSource<Section, Task>!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private var tasks: [Task] = []
    private var selectedIndexPath : IndexPath = []

    // MARK: Set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        configureDataSource()
        fetchTasks()
        setUpNavigationBar()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
        
    private func setUpNavigationBar(){
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Задачи"
        
        let addTaskAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else {return}
            snapshot.appendItems([Task(id: UUID(), title:"Новая задача", description: "Описание новой задачи", creationDate: Date(), completionDate: nil, priority: nil )])
            self.dataSource.apply(snapshot)
        }
        
        let creationDateSortAction = UIAction(title: "Creation Date") { _ in
            self.filterSortOptions.sortOption = .creationDate
            self.useFilter()
        }
        
        let completionDateSortAction = UIAction(title: "Completion Date") { _ in
            self.filterSortOptions.sortOption = .completionDate
            self.useFilter()
        }

        let prioritySortAction = UIAction(title: "Priority") { _ in
            self.filterSortOptions.sortOption = .priority
            self.useFilter()
        }

        let sortMenu = UIMenu(title: "Sort By", children: [creationDateSortAction, completionDateSortAction, prioritySortAction])
        
        let sortTaskAction = UIAction(title: "Sort By...", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: [], state: .off) {_ in}
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort By...", image: nil, primaryAction: sortTaskAction, menu: sortMenu)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addTaskAction, menu: nil)
    }

    // MARK: Configuration
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, task: Task) -> UITableViewCell? in

            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configure(with: task)

            cell.delegate = self
            
            return cell
        }
    }

    private func fetchTasks() {
        tasks = [
            Task(id: UUID(), title: "Задача 1", description: "Описание задачи 1", creationDate: Date(), completionDate: nil, priority: nil ),
            Task(id: UUID(), title: "Задача 2", description: "Описание задачи 2", creationDate: Date(), completionDate: nil, priority: nil ),
            Task(id: UUID(), title: "Задача 3", description: "Описание задачи 3", creationDate: Date(), completionDate: nil, priority: nil )
        ]
        
        applySnapshot(tasks: tasks)
    }

    // MARK: TableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataSource.itemIdentifier(for: indexPath)!
        let taskDetailViewController = TaskDetailViewController(task: task)
        
        taskDetailViewController.delegate = self
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        
        navigationController?.pushViewController(taskDetailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: Actions & Delegate

    func didUpdateTask(task: Task) {
        var currentSnapshot = dataSource.snapshot()
        
        currentSnapshot.insertItems([task], afterItem: dataSource.itemIdentifier(for: selectedIndexPath)!)
        currentSnapshot.deleteItems([dataSource.itemIdentifier(for: selectedIndexPath)!])
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(tasks: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func useFilter(){
        var snapshot = dataSource.snapshot()
        let tasks = snapshot.itemIdentifiers
        
        if let sortOption = filterSortOptions.sortOption {
            let sortedTasks: [Task]
            switch sortOption {
            case .creationDate:
                sortedTasks = tasks.sorted(by: { $0.creationDate > $1.creationDate })
            case .completionDate:
                sortedTasks = tasks.sorted(by: {
                    if let date0 = $0.completionDate, let date1 = $1.completionDate {
                        return date0 < date1
                    } else if let _ = $0.completionDate {
                        return true
                    } else {
                        return false
                    }
                })
            case .priority:
                sortedTasks = tasks.sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
            }
            
            snapshot.deleteItems(tasks)
            snapshot.appendItems(sortedTasks)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func didDeleteTask(task: Task) {
        var currentSnapshot = dataSource.snapshot()
        
        currentSnapshot.deleteItems([task])
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

