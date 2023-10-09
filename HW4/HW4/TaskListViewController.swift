//
//  TaskListViewController.swift
//  HW4
//
//  Created by Alina on 09.10.2023.
//

import UIKit

class TaskListViewController: UIViewController{
    enum TableSection {
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 1000
        return table
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            cell.delegate = self
            return cell
        })
        
        updateDataSource(with: tasks, animate: false)
    }
    
    func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            self.tableView.isEditing.toggle()
            if !self.tableView.isEditing {
                self.tableView.reloadData()
            }
        }
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
                let task = Task(id: UUID(), title: "New Task", description: "Description")
                snapshot.appendItems([task], toSection: .main)
                self.tasks.append(task)
                self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "To-Do List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension TaskListViewController: TaskCellDelegate {
    func didPressDetailDisclosure() {
            
        
        let alert = UIAlertController(title: "Great!", message: "You done it :)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Thanks", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension TaskListViewController: DetailControllerDelegate {
    func dataUpdated(for task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = DetailViewController(with: task, delegate: self)
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
