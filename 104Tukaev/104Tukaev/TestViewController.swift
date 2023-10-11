import UIKit

class TestViewController: UIViewController {
    
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
    
    var tasks: [Task] = []
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
        
        let refreshAction = UIAction { _ in
            
            guard var snapshot = self.dataSource?.snapshot() else { return }
        }
        navigationItem.title = "Main"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .organize, primaryAction: refreshAction, menu: nil)
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
        
        tasks.append(Task( id: UUID(), name: "Aidar", description: "StringStringStringStringStringStringStringString", ProductImage: UIImage(systemName: "pencil.line")))
        
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
            guard var snapshot = dataSource?.snapshot() else { return }
            if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks.remove(at: objectIndex)
                tasks.insert(task, at: objectIndex)
                updateDataSource(with: tasks, animate: false)
            }
        }
    
    }
    
    

