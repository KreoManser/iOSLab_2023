//
//  ViewController.swift
//  HomeWork_4
//
//  Created by Нияз Ризванов on 01.10.2023.
//

import UIKit

enum TableSection {
    case main
    case secodary
}

class ViewController: UIViewController {
    private var count: Int = 0
    
    private lazy var tableTasks: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.delegate = self
        return table
    }()
    
    private lazy var viewCounter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var countTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всего: \(count)"
        label.textColor = .gray
        return label
    }()
    
    var tasks: [Task] = []
    var dataSource: UITableViewDiffableDataSource<TableSection,Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableTasks)
        view.addSubview(viewCounter)
        view.addSubview(countTasksLabel)
        
        setupNavigationBar()
        setupLayout()
        setupDataSource()
    }
    
    private func updateCountLabel() {
        self.count +=  1
        countTasksLabel.text = "Всего: \(count)"
    }
    
    private func deleteCountLabel() {
        self.count -=  1
        countTasksLabel.text = "Всего: \(count)"
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableTasks) { tableTasks, indexPath, task in
            
            let cell = tableTasks.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            return cell
        }
        updateDatasource(with: tasks, animated: false)
    }
    
    func updateDatasource(with tasks: [Task], animated: Bool){
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Задачи"
        let editAction = UIAction { _ in
            self.tableTasks.isEditing.toggle()
            if !self.tableTasks.isEditing {
                self.tableTasks.reloadData()
            }
        }
        
        let addAction = UIAction { _ in
            guard var snapshot = self.dataSource?.snapshot() else { return }
            let newTask = Task(id: UUID(), title: "Новая задача", description: "")
            snapshot.appendItems([newTask], toSection: .main)
            self.tasks.append(newTask)
            self.updateCountLabel()
            self.dataSource?.apply(snapshot)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableTasks.topAnchor.constraint(equalTo: viewCounter.bottomAnchor),
            tableTasks.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableTasks.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableTasks.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            viewCounter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCounter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewCounter.heightAnchor.constraint(equalToConstant: 25),
            
            countTasksLabel.centerYAnchor.constraint(equalTo: viewCounter.centerYAnchor),
            countTasksLabel.leadingAnchor.constraint(equalTo: viewCounter.leadingAnchor,constant: 10)
        ])
    }
    
}
extension ViewController: DetailControllerDelegate {
    func deleteCase(for task: Task) {
        guard var snapshot = dataSource?.snapshot() else { return }
        if let objectIndex = tasks.firstIndex(where: {$0.id == task.id} ){
            tasks.remove(at: objectIndex)
            
            snapshot.deleteItems([task])
            deleteCountLabel()
            updateDatasource(with: tasks, animated: false)
        }
    }
    
    func updateData(for task: Task) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: {$0.id == task.id} ){
            tasks.remove(at: objectIndex)
            tasks.insert(task, at: objectIndex)
            updateDatasource(with: tasks, animated: false)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        if let task = dataSource?.itemIdentifier(for: indexPath){
        let detailViewController = DetailViewController(task: task, delegate: self)
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true )
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}


