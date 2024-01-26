//
//  ViewController.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 21.01.2024.
//

import UIKit

class ViewController: UIViewController {
    let containerView = TaskTableView()
    var dataSource: UITableViewDiffableDataSource<Int, Task>?
    let dataBase = DataBaseManager()
    
    var filteredTasks: [Task] = []

    override func loadView() {
        view = containerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.tableView.delegate = self
        setupNavigationBar()
        setupDataSource()
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            self.containerView.tableView.isEditing.toggle()
            if !self.containerView.tableView.isEditing {
                self.containerView.tableView.reloadData()
            }
        }
        
        let addAction = UIAction { _ in
            let addModelViewController = DetailViewController(delegate: self, task: nil)
            self.present(addModelViewController, animated: true, completion: nil)
        }
        
        let filterAction = UIAction { _ in
            let alert = UIAlertController(
                title: "Фильтр",
                message: "Выберите способ фильтрации",
                preferredStyle: .alert
            )
             
            alert.addAction(UIAlertAction(title: "По приоритету", style: .default) { action in
                self.filterByPriority()
            })
            alert.addAction(UIAlertAction(title: "По дате создания", style: .default) { action in
                self.filterByDateOfCreating()
            })
            alert.addAction(UIAlertAction(title: "По дате завершения", style: .default) { action in
                self.filterBydateOfExpiration()
            })
            alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
        let addNavigationBarItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
        let filterNavigationBarItem = UIBarButtonItem(systemItem: .search, primaryAction: filterAction, menu: nil)
        navigationItem.rightBarButtonItems = [addNavigationBarItem, filterNavigationBarItem]
    }
    
    func filterByPriority() {
        filteredTasks = dataBase.getAllTasks().sorted(by: { $0.priority > $1.priority })
        updateDataSource(with: filteredTasks)
    }
    
    func filterByDateOfCreating() {
        filteredTasks = dataBase.getAllTasks().sorted(by: { $0.dateOfCreating < $1.dateOfCreating })
        updateDataSource(with: filteredTasks)
    }
    
    func filterBydateOfExpiration() {
        filteredTasks = dataBase.getAllTasks().sorted(by: { $0.dateOfExpiration < $1.dateOfExpiration })
        updateDataSource(with: filteredTasks)
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: containerView.tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier:
                   TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            
            return cell
        })
        updateDataSource(with: dataBase.getAllTasks())
    }
    
    func updateDataSource(with tasks: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Task>()
        snapshot.appendSections([0])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
}

extension ViewController: DetailControllerDelegate {
    func dataUpdate() {
        updateDataSource(with: dataBase.getAllTasks())
    }
    
    func updateDataBase(by task: Task?) {
        guard let task = task else { return }
        dataBase.update(task: task)
        updateDataSource(with: dataBase.getAllTasks())
    }
    
    func addNewTaskDataBase(by task: Task) {
        dataBase.insert(task: task, at: 0)
        updateDataSource(with: dataBase.getAllTasks())
    }
}
                                
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let cell = dataBase.getAllTasks()[sourceIndexPath.row]
        dataBase.removeTask(at: sourceIndexPath.row)
        dataBase.insert(task: cell, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                guard let self = self else { return }
                
                self.dataBase.removeTask(at: indexPath.row)
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, Task>()
                snapshot.appendSections([0])
                snapshot.appendItems(self.dataBase.getAllTasks())
                self.dataSource?.apply(snapshot, animatingDifferences: true)
                
                completionHandler(true)
            }
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = true
            return configuration
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let detailController = DetailViewController(delegate: self, task: task)
            
            self.present(detailController, animated: true, completion: nil)
        }
    }
}
