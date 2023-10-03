import UIKit

class ViewController: UIViewController {
    
    private enum TableSection {
        case main
        case secondary
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.delegate = self;
        tableView.separatorStyle = .none;
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier);
        tableView.estimatedRowHeight = 120;
        
        return tableView;
    }()
    
    private var tasks: [Task] = [];
    private var dataSource: UITableViewDiffableDataSource<TableSection, Task>?;
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        let currentDate = Date();
        let calendar = Calendar.current;
        var dateComponents = DateComponents();
        dateComponents.year = 2023;
        dateComponents.month = 10;
        dateComponents.day = 1;
        let doneDate = calendar.date(from: dateComponents);
        
        tasks.append(Task(id: UUID(), title: "Задача 1", description: "Описание задачи", status: "Выполнено", creationDate: currentDate, completionDate: doneDate!));
        tasks.append(Task(id: UUID(), title: "Задача 2", description: "Описание задачи", status: "Не выполнено", creationDate: currentDate, completionDate: doneDate!));
        
        view.addSubview(tableView);
        setupLayoutTableView();
        setupNavigationBar();
        setupDataSource();
        
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell;
            cell.configureCell(with: task);
        
            return cell;
        })
        updateDataSource(with: tasks, animate: false);
    }
    
    private func setupNavigationBar() {
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let currentDate = Date();
            let calendar = Calendar.current;
            var dateComponents = DateComponents();
            dateComponents.year = 2023;
            dateComponents.month = 10;
            dateComponents.day = 2;
            let doneDate = calendar.date(from: dateComponents);
            let task = Task(id: UUID(), title: "Новая задача", description: "Описание новой задачи", status: "не выполнено", creationDate: currentDate, completionDate: doneDate!);
            snapshot.appendItems([task], toSection: .secondary);
            self.tasks.append(task);
            self.dataSource?.apply(snapshot);
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil);
    }
   
    private func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>();
        snapshot.appendSections([.main, .secondary]);
        snapshot.appendItems(tasks);
        dataSource?.apply(snapshot);
    }
    
    func setupLayoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]);
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300;
    }

}

extension ViewController: DetailControllerDelegate {
    func dataUpdate(for task: Task) {
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex);
            tasks.insert(task, at: objectIndex);
            updateDataSource(with: tasks, animate: false);
        }
    }
    func removeTask(task: Task) {
        if let indexToRemove = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToRemove);
        }
        
        updateDataSource(with: tasks, animate: false);
        navigationController?.popViewController(animated: true);
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = TaskDetailScreenViewController(with: task, delegate: self);
            navigationController?.pushViewController(detailController, animated: true);
            tableView.deselectRow(at: indexPath, animated: true);
        }
    }
}
