//
//  TaskListViewController.swift
//  Homework4
//
//  Created by kerik on 01.10.2023.
//

import UIKit

class TaskListViewController: UIViewController {
    enum TableViewSections {
        case main
    }
    
    private var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableViewSections, Task>?
    
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var customButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.tintColor = .systemBlue
        button.setTitleColor(.clear, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(tasksTableView)
        setLayout()
        setupNavigationBar()
        setupDataSource()
    }
}
extension TaskListViewController {
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension TaskListViewController {
    private func setupNavigationBar() {
        navigationItem.title = "To Do List"
        let addAction = UIAction { [weak self] _ in
            self?.navigationController?.pushViewController(NewTaskViewController(delegate: self), animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
        
        let customLeftBarButton = UIBarButtonItem(customView: customButton)
        customLeftBarButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        customLeftBarButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        navigationItem.leftBarButtonItem = customLeftBarButton
        setFilterButton()
    }
    
    private func setFilterButton() {
        //сортировка по приоритету (возрастание)
        let priorityFilterAction = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue < $1.priority.rawValue }
            self.updateData(with: self.tasks)
        }
        
        //сортировка по приоритету (убывание)
        let priorityFilterActionByDescending = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue > $1.priority.rawValue }
            self.updateData(with: self.tasks)
        }
        
        //сортировка по датам (от ранних к поздним)
        let dateEarlyFilterAction = { (action: UIAction) in
            self.tasks.sort { $0.creationDate > $1.creationDate }
            self.updateData(with: self.tasks)
        }
        
        //сортировка по датам (от поздних к ранним)
        let dateLaterFilterAction = { (action: UIAction) in
            self.tasks.sort { $0.creationDate < $1.creationDate }
            self.updateData(with: self.tasks)
        }
        
        customButton.menu = UIMenu(title: "Сортировка".uppercased(), children: [
            UIAction(title: "По приоритету(возрастание)", handler: priorityFilterAction),
            UIAction(title: "По приоритету(убывание)", handler: priorityFilterActionByDescending),
            UIAction(title: "По новизне(сначала старые)", handler: dateLaterFilterAction),
            UIAction(title: "По новизне(сначала новые)", handler: dateEarlyFilterAction),
        ])
                
        customButton.showsMenuAsPrimaryAction = true
        customButton.changesSelectionAsPrimaryAction = true
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let taskDetailViewController = TaskDetailViewController(task: task, delegate: self)
            navigationController?.pushViewController(taskDetailViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tasksTableView, cellProvider: { tableView, indexPath, task in
            let cell = self.tasksTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            return cell
        })
        self.updateData(with: self.tasks)
    }
    
    private func updateData(with tasks: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension TaskListViewController: NewTaskDelegate {
    func addNewTask(with newTask: Task) {
        let task = newTask
        tasks.append(task)
        updateData(with: tasks)
        navigationController?.popViewController(animated: true)
    }
}

extension TaskListViewController: TaskUpdatesDelegate {
    func updateTask(task: Task) {
        let currentTask = task
        if let indexToUpdate = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToUpdate)
            tasks.insert(contentsOf: [currentTask], at: indexToUpdate)
        }
        updateData(with: tasks)
        navigationController?.popViewController(animated: true)
    }
    
    func removeTask(task: Task) {
        if let indexToRemove = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToRemove)
        }
        updateData(with: tasks)
        navigationController?.popViewController(animated: true)
    }
}

