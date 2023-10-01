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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(tasksTableView)
        setLayout()
        setupNavigationBar()
        setupDataSource()
    }
}
extension TaskListViewController: UITableViewDelegate {
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
        navigationItem.title = "To Do"
        let addAction = UIAction { _ in
            self.navigationController?.pushViewController(NewTaskViewController(delegate: self), animated: true)
            
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
}
extension TaskListViewController {
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
}

extension TaskListViewController: NewTaskDelegate {
    func addNewTask(with newTask: Task) {
        var task = newTask
        if task.title == "" {
            task.title = "Новая задача"
        }
        tasks.append(task)
        updateData(with: tasks)
        navigationController?.popViewController(animated: true)
    }
}


