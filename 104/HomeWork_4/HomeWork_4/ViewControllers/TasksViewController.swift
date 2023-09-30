//
//  TasksViewController.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 27.09.2023.
//

import UIKit

// MARK: - TasksViewController
class TasksViewController: UIViewController {
    // MARK: - table sections enum
    enum TableViewSections {
        case main
    }
    // MARK: - UI elements
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 120
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var customBarButtonItem: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.clear, for: .normal)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        return button
    }()
    
    // MARK: - TableView data
    var tasks: [ToDoTask] = []
    var dataSource: UITableViewDiffableDataSource<TableViewSections, ToDoTask>?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for _ in 0 ..< 5 {
            tasks.append(ToDoTask(name: "sfsdf qeqewqesdfssdfsdfssfsdfsdfsdfTask", description: "pohdlaldladapdlaldaldafkjnskfnkjskjnkasn"))
        }
        var t = ToDoTask(name: "med", description: " ")
        t.priority = .medium
        tasks.append(t)
        
        addSubViews(tasksTableView)
        configureUI()
        setupNavigationBar()
        setupFilterButton()
        setupDataSource()
    }
}

// MARK: - Extencion TasksViewController

extension TasksViewController {
    private func addSubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    // MARK: - Func configure UI
    private func configureUI() {
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

extension TasksViewController {
    
    // MARK: - Func setup navigation bar
    private func setupNavigationBar() {
        navigationItem.title = "To Do"
        
        let cusmotButton = UIBarButtonItem(customView: customBarButtonItem)
        cusmotButton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cusmotButton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let addAction = UIAction { _ in
            self.navigationController?.pushViewController(NewTaskViewController(), animated: true)
            self.customBarButtonItem.select(<#T##sender: Any?##Any?#>)
            var n = ToDoTask(name: "new Task", description: "dad")
            n.priority = .high
            n.isCompleted = true
            self.tasks.append(n)
            self.updateData(with: self.tasks)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)

        navigationItem.rightBarButtonItem = cusmotButton
    }
    
    // MARK: - Func setup filter button
    private func setupFilterButton() {
        /// сортирует по дате создания (сначала ранние)
        let creationTimeEarlyFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate < $1.creationDate }
            self.updateData(with: self.tasks)
        }
        
        /// сортирует по дате создания (сначала поздние)
        let creationTimeLateFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate > $1.creationDate }
            self.updateData(with: self.tasks)
        } 
        
        /// сортирует по выполению (сначала выполненные)
        let firstIsCompletedActionClosure = { (action: UIAction) in
            self.tasks.sort { (task1: ToDoTask, task2: ToDoTask) in
                if task1.isCompleted && !task2.isCompleted {
                    return true
                } 
                else if !task1.isCompleted && task2.isCompleted {
                    return false
                }
                else {
                    return false
                }
            }
            self.updateData(with: self.tasks)
        }
        
        /// сортирует по выполению (сначала не выполненные)
        let firstIsNotCompletedActionClosure = { (action: UIAction) in
            self.tasks.sort { (task1: ToDoTask, task2: ToDoTask) in
                if !task1.isCompleted && task2.isCompleted {
                    return true
                }
                else if task1.isCompleted && !task2.isCompleted {
                    return false
                }
                else {
                    return false
                }
            }
            self.updateData(with: self.tasks)
        }
        
        /// сортирует по приоритету (по убыванию)
        let descendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue > $1.priority.rawValue }
            self.updateData(with: self.tasks)
        }
        
        /// сортирует по приоритету (по возрастанию)
        let ascendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue < $1.priority.rawValue }
            self.updateData(with: self.tasks)
        }
        
        
        customBarButtonItem.menu = UIMenu(title: "Сортировка".uppercased(), children: [
            UIAction(title: "По дате создания: ранние", state: .on, handler: creationTimeEarlyFilterActionClosure),
            UIAction(title: "По дате создания: поздние", handler: creationTimeLateFilterActionClosure),
            UIAction(title: "сначала выполненные", handler: firstIsCompletedActionClosure),
            UIAction(title: "сначала не выполненные", handler: firstIsNotCompletedActionClosure),
            UIAction(title: "По приоритету max", handler: descendingPriorityFilterActionClosure),
            UIAction(title: "По приоритету min", handler: ascendingPriorityFilterActionClosure)
        ])
        
        customBarButtonItem.showsMenuAsPrimaryAction = true
        customBarButtonItem.changesSelectionAsPrimaryAction = true
    }
}

// MARK: - TableView implementation
extension TasksViewController: UITableViewDelegate {
    
    // MARK: - setup Data Sourve
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tasksTableView, cellProvider: { tableView, indexPath, task in
            let cell = self.tasksTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            return cell
        })
        self.updateData(with: self.tasks)
    }
    
    private func updateData(with tasks: [ToDoTask]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, ToDoTask>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
}
