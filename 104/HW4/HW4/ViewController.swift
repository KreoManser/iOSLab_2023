//
//  ViewController.swift
//  HW4
//
//  Created by Kseniya Skvortsova on 05.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum TableSection {
        case main
    }
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .singleLine
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return table
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tasks=generateData()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupLayout()
        setupNavigationBar()
        setupDataSource()
    }
    
    func generateData() -> [Task]{
        let data = [Task(id: UUID(), name: "Make homework", subtitle: "Homework for IOS course", startingDate: "26.09.23", endingDate: "05.10.23", type: "Homework"),
                    Task(id: UUID(), name: "Make homework", subtitle: "Homework for IOS course", startingDate: "26.09.23", endingDate: "05.10.23", type: "Homework"),
                    Task(id: UUID(), name: "Make homework", subtitle: "Homework for IOS course", startingDate: "26.09.23", endingDate: "05.10.23", type: "Homework")]
        return data
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
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
    
    func setupNavigationBar() {
        let addAction = UIAction { _ in
            
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let task = Task(id: UUID(),
                            name: "New task",
                            subtitle: "New task",
                            startingDate: "-",
                            endingDate: "-",
                            type: "Task")
            snapshot.appendItems([task], toSection: .main)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.title = "To do list"
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

extension ViewController: TaskCellDelegate {
    func didPressDetailDisclosure(for task: Task) {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            if let objectIndex = self.tasks.firstIndex(where: { $0.id == task.id }) {
                self.tasks.remove(at: objectIndex)
                self.updateDataSource(with: self.tasks, animate: false)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
}

extension ViewController: TaskDetailControllerDelegate {
    func dataUpdated(for task: Task) {
        guard var snapshot = dataSource?.snapshot() else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = TaskDetailViewController(with: task, delegate: self)
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
