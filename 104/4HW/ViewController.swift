//
//  ViewController.swift
//  4HW
//
//  Created by Ruslan on 01.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum TableSection {
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 120
        return tableView
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        let currentDate = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2026
        dateComponents.month = 2
        dateComponents.day = 2
        let doneDate = calendar.date(from: dateComponents)
        
        for _ in 1...2 {
            tasks.append(Task(id: UUID(), title: "Заголовок1", description: String(repeating: " задача1 ", count: 20), status: "выполнено", dateOfCreation: currentDate, completionDate: doneDate!))
        }
        
        view.addSubview(tableView)
        setupLayoutTableView()
        setupNavigationBar()
        setupDataSource()
        
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
        
            return cell
        })
        updateDataSource(with: tasks, animate: false)
    }
    
    func setupNavigationBar() {
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let currentDate = Date()
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.year = 2024
            dateComponents.month = 11
            dateComponents.day = 21
            let doneDate = calendar.date(from: dateComponents)
            let task = Task(id: UUID(), title: "Заголовок", description: String(repeating: " задача ", count: 1), status: "не выполнено", dateOfCreation: currentDate, completionDate: doneDate!)
            snapshot.appendItems([task], toSection: .secondary)
            self.tasks.append(task)
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
   

    
    func updateDataSource(with tasks: [Task], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
    
    func setupLayoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

}

extension ViewController: DetailControllerDelegate {
    func dataUpdate(for task: Task) {
        guard var snapshot = dataSource?.snapshot() else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDataSource(with: tasks, animate: false)
        }
    }
    func removeTask(task: Task) {
            if let indexToRemove = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks.remove(at: indexToRemove)
            }
            updateDataSource(with: tasks, animate: false)
            navigationController?.popViewController(animated: true)
        }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = dataSource?.itemIdentifier(for: indexPath)
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = TaskDetailScreenViewController(with: task, delegate: self)
            navigationController?.pushViewController(detailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

