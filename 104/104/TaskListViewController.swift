//
//  ViewController.swift
//  104
//
//  Created by Dmitry on 29.09.2023.
//


import UIKit

enum TableSection {
    case main
}

class TaskListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(TaskTableCell.self, forCellReuseIdentifier: TaskTableCell.reuseIdentifier)
        return table
    }()
    
    private var tasks = [Task]()
    private var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tasks.append(Task(id: UUID(), name: "Новая задача", description: "Описание"))
        
        setUpTableViewConstraints()
        setUpNavigationBar()
        setUpDataSource()
    }
}

extension TaskListViewController {
    
    private func setUpNavigationBar() {
        let addAction = UIAction { _ in
            self.tasks.insert(Task(id: UUID(), name: "Новая задача", description: "Описание задачи"), at: 0)
            var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.tasks)
            self.dataSource?.apply(snapshot)
        }
        navigationItem.title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableCell.reuseIdentifier, for: indexPath) as! TaskTableCell
            let task = self.dataSource?.itemIdentifier(for: indexPath)
            cell.configureCell(with: task!, delegate: self)
            return cell
        })
        updateDataSource(with: tasks, animate: true)
    }
    
    private func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
}

extension TaskListViewController: TaskDetailScreenDelegate {
    func didFinishEditTask(with: Task) {
        guard var _ = dataSource?.snapshot() else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == with.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(with, at: objectIndex)
            updateDataSource(with: tasks, animate: true)
        }
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            navigationController?.pushViewController(TaskDetailViewController(with: task, delegate: self), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension TaskListViewController: TaskCellDelegate {
    func taskIsDone(task: Task) {
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            updateDataSource(with: tasks, animate: true)
        }
    }
}




