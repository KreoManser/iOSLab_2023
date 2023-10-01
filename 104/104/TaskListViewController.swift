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

class TaskListViewController: UIViewController, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(TaskTableCell.self, forCellReuseIdentifier: TaskTableCell.reuseIdentifier)
        return table
    }()
    
    lazy var editTableButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        return button
    }()
    
    var tasks = [Task]()
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tasks.append(Task(name: "Задача", description: "Description"))
        tasks.append(Task(name: "Задача", description: "аываывваыв"))
        tasks.append(Task(name: "Задача", description: "аываывваыв"))
        tasks.append(Task(name: "Задача", description: "аываывваыв"))
        tasks.append(Task(name: "Задача", description: "аываывваыв"))
        tasks.append(Task(name: "Задача", description: "аываывваыв"))
        view.addSubview(tableView)
        setUpTableViewConstraints()
        setUpNavigationBar()
        setUpDataSource()
    }
    
    func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableCell.reuseIdentifier, for: indexPath) as! TaskTableCell
            let task = self.dataSource?.itemIdentifier(for: indexPath)
            cell.configureCell(with: task!)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(tasks))
        dataSource?.apply(snapshot)
    }
    
    func setUpNavigationBar() {
        
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
        }
        
        let addAction = UIAction { _ in
            self.tasks.append(Task(name: "Новая задача", description: "Описание задачи"))
            var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
            snapshot.appendSections([.main])
            snapshot.appendItems(self.tasks)
            self.dataSource?.apply(snapshot)
            print(self.tasks)
        }
        
        navigationItem.title = "Tasks"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension TaskListViewController {
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskScreen = TaskDetailViewController()
        taskScreen.configureViewController(with: tasks[indexPath.row])
        navigationController?.pushViewController(taskScreen, animated: true)
    }
}





