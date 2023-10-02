//
//  ViewController.swift
//  HW4_ToDoList
//
//  Created by Артур Миннушин on 01.10.2023.
//

import UIKit

class TaskViewController: UIViewController, UITableViewDelegate, UserCellDelegate {
    func didPressDetailDisclosure() {
        <#code#>
    }
    
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<tableSelection, Task>?
    var dataBase: [Task] = [
        Task(id: UUID(), nameTask: "Сделать ДЗ", descriptionTask: "Сделать четвертое задание из курса iOs"),
        Task(id: UUID(), nameTask: "Пойти гулять", descriptionTask: "Сделать четвертое задание из курса iOs"),
        Task(id: UUID(), nameTask: "Купить продукты", descriptionTask: "Сделать четвертое задание из курса iOs"),
        Task(id: UUID(), nameTask: "Лечь спать", descriptionTask: "Сделать четвертое задание из курса iOs"),
        Task(id: UUID(), nameTask: "Забрать посылку", descriptionTask: "Сделать четвертое задание из курса iOs")]
    
    enum tableSelection{
        case main
        case secondary
    }
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 80
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<5 {
            tasks.append(dataBase[i])
        }
        
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        
        
        setuplayout()
        setupNavigationBar()
        setupDataSource()
        
    }
    
    func setuplayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Task"
        
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            cell.delegate = self
            return cell
        })
        updateDataSource(with: tasks)
    }
    
    func updateDataSource(with tasks: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<tableSelection, Task>()
        snapshot.appendSections([.main, .secondary])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        
    }
}

