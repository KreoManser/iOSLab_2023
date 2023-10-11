import UIKit

class ViewController: UIViewController {
    
    enum TableSection {
        case main
    }
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 120
        return table
    }()
    var aletController: UIAlertController?
    var tasks: [Task] = [
        Task( id: UUID(), name: "Aidar", description: "встать", ProductImage: UIImage(systemName: "pencil.line")),
        Task( id: UUID(), name: "bidar", description: "покушать", ProductImage: UIImage(systemName: "pencil.line")),
        Task( id: UUID(), name: "cidar", description: "сесть", ProductImage: UIImage(systemName: "pencil.line"))]
    var dataSource: UITableViewDiffableDataSource<TableSection , Task>?
    
    private func setupDataSourse(){
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.ConfigureCell(with: task)
            return cell
        })
        updateDataSource(with: tasks, animate: false)
    }
    
    private func setupNavigationBar(){
        
        let sortUpAction = UIAction(title: "сортировать А-я") { _ in
            
            var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
            var sortedTasks = self.tasks
            sortedTasks.sort { task1, task2 in
                return task1.name < task2.name
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(sortedTasks)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
            self.didPressSortButton(message: "Отсортировано А-я")
        }
        
        let sortDownAction = UIAction(title: "сортировать Я-а") { _ in
            
            var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
            var sortedTasks = self.tasks
            sortedTasks.sort { task1, task2 in
                return task1.name > task2.name
            }
            snapshot.appendSections([.main])
            snapshot.appendItems(sortedTasks)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
            self.didPressSortButton(message: "Отсортировано Я-а")
        }
        
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
            
        }
        
        let menu = UIMenu(title: "", children: [sortUpAction, sortDownAction])
        navigationItem.title = "Main"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", image: nil, primaryAction: nil, menu: menu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction)
    }
    
    
    public func didPressSortButton(message: String){
        let alert = UIAlertController(title: "Уведомление", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    private lazy var button: UIButton = {
        
        let action = UIAction{ _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let task = Task(id: UUID(), name: "name ", description: " kakoe to opisanie", ProductImage: UIImage(systemName: "pencil.line"))
            
            snapshot.appendItems([task], toSection: .main)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("add", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks.append(Task( id: UUID(), name: "Aidar", description: "спать", ProductImage: UIImage(systemName: "pencil.line")))
        
        view.addSubview(tableView)
        view.addSubview(button)
        view.backgroundColor = .white
        setupLayout()
        setupDataSourse()
        setupNavigationBar()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -120),
        ])
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailConroller = TaskDetailViewController(with: task, delegate: self)
            navigationController?.pushViewController(detailConroller, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension ViewController: TaskDetailControllerDelegate{
    
    func dateUpdated(for task: Task) {
        
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            if task.name == "$delete$" {
                updateDataSource(with: tasks, animate: false)
                return
            }
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}
