//
//  ViewController.swift
//  HW_104
//
//  Created by Азат Зиганшин on 02.10.2023.
//

import UIKit

class TaskListScreen: UIViewController {

    enum TableSection {
        case main
    }
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return table
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tasks = [
            Task(title: "Пойти на тренировку", description: "Пожать 100 кг"),
            Task(title: "Сделать дз по iOS", description: "Изучить материал 4 пары, сделать домашнее задание")
        ]
        setupLayout()
        setupDataSource()
        setupNavigationBar()
        self.title = "Список задач"
        
    }

    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
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

    
}

extension TaskListScreen {
    func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        let addAction = UIAction { _ in
            let task = Task(title: "Новая задача", description: "Описание задачи")
            self.tasks.append(task)
            self.updateDataSource(with: self.tasks, animate: true)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
}

extension TaskListScreen: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let taskDetailScreen = TaskDetailScreen(with: task, delegate: self)
            navigationController?.pushViewController(taskDetailScreen, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension TaskListScreen: TaskDetailScreenDelegate {
    func dataUpdated(task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}
