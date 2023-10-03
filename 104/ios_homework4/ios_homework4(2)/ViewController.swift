
import UIKit

struct Task: Hashable, Identifiable {
    let id: UUID 
    let name: String
    let description: String
}

class ViewController: UIViewController, UITableViewDelegate {
    
    enum TableSection {
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .singleLine
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 150
        return table
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< 6 {
            tasks.append(Task(id: UUID(), name: "Buy", description: "Buy apple, carrot, banana, orange"))
            tasks.append(Task(id: UUID(), name: "Do homework", description: "Math, art, programming"))
            tasks.append(Task(id: UUID(), name: "Cook", description: "Breakfast, lunch, dinner"))
        }
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        setupLayout()
        setUpDataSource()
        setupNavigationBar()
    }

    func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.configureCell(with: task)
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
    
    func addTask() {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Task Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Task Description"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text, let description = alertController.textFields?[1].text else { return }
            let task = Task(id: UUID(), name: name, description: description)
            guard var snapshot = self.dataSource?.snapshot() else { return }
            
            let section = ViewController.TableSection.main
            snapshot.appendItems([task], toSection: section)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let task = tasks[indexPath.row]

        let detailController = DetailTableViewController(with: task, delegate: self)
        navigationController?.pushViewController(detailController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func setupNavigationBar() {
        navigationItem.title = "My Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { (_) in
            self.addTask()
        }), menu: nil)
    }
    
    func setupLayout() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
    }
}

extension ViewController: DetailTableViewControllerDelegate {
    func dataUpdated(for task: Task) {
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}

