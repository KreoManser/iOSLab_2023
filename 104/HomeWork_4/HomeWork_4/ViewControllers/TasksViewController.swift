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
    // MARK: - UITableViews
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - UIButtons
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
        
        tasks.append(ToDoTask(name: "дедлайн ios", description: "Дофиксить баг", priority: .high))
        tasks.append(ToDoTask(name: "не проспать пары", description: "(по возможности)", priority: .low))
        
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
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1)
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
            self.navigationController?.pushViewController(NewTaskViewController(delegate: self), animated: true)
            
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)

        navigationItem.rightBarButtonItem = cusmotButton
    }
    
    // MARK: - Func setup filter button
    private func setupFilterButton() {
        /// сортирует по дате создания (сначала ранние)
        let creationTimeEarlyFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate < $1.creationDate }
            self.updateData(with: self.tasks, animate: true)
        }
        
        /// сортирует по дате создания (сначала поздние)
        let creationTimeLateFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate > $1.creationDate }
            self.updateData(with: self.tasks, animate: true)
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
            self.updateData(with: self.tasks, animate: true)
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
            self.updateData(with: self.tasks, animate: true)
        }
        
        /// сортирует по приоритету (по убыванию)
        let descendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue > $1.priority.rawValue }
            self.updateData(with: self.tasks, animate: true)
        }
        
        /// сортирует по приоритету (по возрастанию)
        let ascendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.priority.rawValue < $1.priority.rawValue }
            self.updateData(with: self.tasks, animate: true)
        }
        
        // MARK: - UIMenu for customBarButtonItem
        customBarButtonItem.menu = UIMenu(title: "Сортировка".uppercased(), children: [
            UIAction(title: "Сначала старые", state: .on, handler: creationTimeEarlyFilterActionClosure),
            UIAction(title: "Сначала новые", handler: creationTimeLateFilterActionClosure),
            UIAction(title: "Сначала выполненные", handler: firstIsCompletedActionClosure),
            UIAction(title: "Сначала не выполненные", handler: firstIsNotCompletedActionClosure),
            UIAction(title: "По приоритету max", handler: descendingPriorityFilterActionClosure),
            UIAction(title: "По приоритету min", handler: ascendingPriorityFilterActionClosure)
        ])
        
        customBarButtonItem.showsMenuAsPrimaryAction = true
        customBarButtonItem.changesSelectionAsPrimaryAction = true
    }
}

// MARK: - TableView implementation
extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath) {
            let taskDetailViewController = TaskDetailViewController(task: task, delegate: self)
            navigationController?.pushViewController(taskDetailViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - setup Data Sourve
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tasksTableView, cellProvider: { tableView, indexPath, task in
            let cell = self.tasksTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as! TaskTableViewCell
            cell.configureCell(with: task)
            return cell
        })
        self.updateData(with: self.tasks, animate: false)
    }
    
    // MARK: - updateData
    private func updateData(with tasks: [ToDoTask], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, ToDoTask>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
}

// MARK: - NewTaskDelegate emplementation
extension TasksViewController: NewTaskDelegate {
    func addNewTask(with newTask: ToDoTask) {
        
        var task = newTask
        if task.name == "" {
            task.name = "Новая задача"
        }
        tasks.append(task)
        updateData(with: tasks, animate: false)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TaskUpdatesDelegate implementation
extension TasksViewController: TaskUpdatesDelegate {
    func updateTask(task: ToDoTask) {
       
        var currentTask = task
        if currentTask.isCompleted {
            currentTask.IsCompletedImageName = "RadioButtonFill"
        }
        else {
            currentTask.IsCompletedImageName = "RadioButtonEmpty"
        }
        
        if let indexToUpdate = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToUpdate)
            tasks.insert(contentsOf: [currentTask], at: indexToUpdate)
        }
        updateData(with: tasks, animate: false)
        navigationController?.popViewController(animated: true)
    }
    
    func removeTask(task: ToDoTask) {
        if let indexToRemove = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToRemove)
        }
        updateData(with: tasks, animate: false)
        navigationController?.popViewController(animated: true)
    }
}


