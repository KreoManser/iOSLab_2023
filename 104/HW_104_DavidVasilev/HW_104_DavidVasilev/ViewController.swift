import UIKit

class ViewController: UIViewController, TaskCellDelegate {
    enum TableSection{
        case main
        case secondary
    }
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection ,Task>?
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.rowHeight = 100
        table.backgroundColor = .systemMint
        table.register( TaskTableViewCell.self,
                        forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func setupDataSource(){
        dataSource = UITableViewDiffableDataSource(
            tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TaskTableViewCell.reuseIdentifier,
                for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            cell.delegate = self
            return cell
        })
        updateDataSource(with: tasks, animate: false)
    }
    func deleteCell(task: Task) {
        var snapshot = dataSource?.snapshot()
        snapshot?.deleteItems([task])
        dataSource?.apply(snapshot!)
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }){
            tasks.remove(at: objectIndex)
        }
    }
    func  updateDataSource(with tasks: [Task], animate: Bool){
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main, .secondary  ])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    func setupNavigationBar(){
        let addAction = UIAction{ _ in
            guard var snapshot = self.dataSource?.snapshot() else  {return}
            let task = Task(id: UUID(),title: "New task", shortDescription: "", fullDescription: "")
            snapshot.appendItems([task], toSection: .secondary)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        navigationItem.title = "Your Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add , primaryAction: addAction, menu: nil)
    }
}

extension ViewController: DetailControllerDelegate {
    func dataUpdate(for task: Task) {
        guard (dataSource?.snapshot()) != nil else {return}
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }){
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks , animate: false)
        }
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath){
            let detailController = DetailViewController(with: task, delegate: self)
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: TaskTableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("234S")
            tableView.beginUpdates()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
