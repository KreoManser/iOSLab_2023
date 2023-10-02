//
//  ViewController.swift
//  ToDoApp
//
//  Created by Faki Doosuur Doris on 30.09.2023.
//

import UIKit

class TaskListViewController: UIViewController {
    enum TableSection {
        case main
    }
    
    enum FilterCriteria {
        case all
        case completed
        case priority(Priority)
    }
    
    enum SortCriteria {
        case all
        case creationDate(ascending: Bool)
        case completionDate(ascending: Bool) //Due date
        case priority(ascending: Bool)
    }
    
    private lazy var currentFilterCriteria: FilterCriteria = .all
    private lazy var currentSortCriteria: SortCriteria = .creationDate(ascending: true)
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        return table
    }()
    
   private lazy var  filterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "Due", "Priority"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0 // Default selection
        return segmentedControl
    }()
    
    private lazy var sortByDateButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Sort by Date", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    private lazy var sortByPriorityButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Sort by Priority", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    private lazy var sortByCompletionButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Sort by Completion", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    var tasks: [TaskToDo] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, TaskToDo>?
    var dataSourceSnaphot: NSDiffableDataSourceSnapshot<TableSection, TaskToDo>?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemPink
            view.addSubview(filterSegmentedControl)
            view.addSubview(sortByDateButton)
            view.addSubview(sortByPriorityButton)
            view.addSubview(sortByCompletionButton)
            view.addSubview(tableView)
            
            // Add action handlers to the sorting buttons
            sortByDateButton.addTarget(self, action: #selector(sortByDateButtonTapped), for: .touchUpInside)
            sortByPriorityButton.addTarget(self, action: #selector(sortByPriorityButtonTapped), for: .touchUpInside)
            sortByCompletionButton.addTarget(self, action: #selector(sortByCompletionButtonTapped), for: .touchUpInside)
            filterSegmentedControl.addTarget(self, action: #selector(filterOptionSelected), for: .valueChanged)

            tasks.append(TaskToDo(id: UUID(), tasks: "Building an app", description: "With the use of diffable datasource , create a to do list", isCompleted: false, creationDate: Date(month: 12, day: 3, year:2023 ), completionDate: Date(month: 12, day: 4, year: 2023), priority: Priority(rawValue: 2)!))
            
            setUpNavigationBar()
            setUpDataSource()
            setupLayout()
    }

 func setUpNavigationBar() {
       let addAction = UIAction { [weak self] _ in
            self?.presentTask()
        }
        self.navigationItem.title = "MyToDoList"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction, menu: nil)
    }
 func presentTask() {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
          textField.placeholder = "Enter Task Title"
        }
        alertController.addTextField { textField in
          textField.placeholder = "Enter Task Description"
        }
        alertController.addTextField { textField in
          textField.placeholder = "Enter Priority (0-2)"
        }
        
        let datePickerTextField = alertController.textFields?[2]
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerTextField?.inputView = datePicker
        
        let addAction = UIAlertAction(title: "Add Task", style: .default) { [weak self] _ in
            guard let self = self,
                  let titleTextField = alertController.textFields?[0],
                  let descriptionTextFied = alertController.textFields?[1],
                  let priorityTextField = alertController.textFields?[2],
                  let title = titleTextField.text,
                  let taskDescription = descriptionTextFied.text,
                  let priorityStr = priorityTextField.text,
                  let priorityInt = Int(priorityStr),
                  !title.isEmpty else {
                return
         }
            let selectedDate = datePicker.date
            _ = Priority(rawValue: min(max(priorityInt, 0), 2))
            let newTask = TaskToDo(id: UUID(), tasks: title, description: taskDescription, isCompleted: false, creationDate:Date() ,completionDate:selectedDate, priority: Priority(rawValue:  priorityInt)!)
             self.tasks.append(newTask)
            applySnapshot(tasks: self.tasks)
        }
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteTask(at indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
 }
    
    func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
            cell.titleLabel.text = task.tasks
            cell.descriptionLabel.text = task.description
            cell.priorityLabel.text = "Priority: \(task.priority.rawValue)"
            if task.priority.rawValue == 2 {
                cell.titleLabel.textColor = .red //if the task is very important , letters should be red.
            }
            
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
                if let completionDate = task.completionDate {
                    cell.dateLabel.text = dateFormatter.string(from: completionDate)
                } else {
                    cell.dateLabel.text = "Not completed"
    }
       return cell
    })
      applySnapshot(tasks: tasks)
}
    
    func applySnapshot(tasks: [TaskToDo], animatingDifferences: Bool = true) {
        var newSnapshot = NSDiffableDataSourceSnapshot<TableSection,TaskToDo>()
        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(tasks, toSection: .main)
        dataSourceSnaphot = newSnapshot
        dataSource?.apply(dataSourceSnaphot!, animatingDifferences: animatingDifferences)
  }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sortByPriorityButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        
            filterSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
                        
            sortByDateButton.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 16),
            sortByDateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -130),
                        
            sortByPriorityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            sortByPriorityButton.topAnchor.constraint(equalTo:filterSegmentedControl.bottomAnchor, constant: 16),
                        
            sortByCompletionButton.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor, constant: 16),
            sortByCompletionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 110),
            
        ])
    }
    
    func filterTasks() {
            switch currentFilterCriteria {
            case .all:
                // Show all tasks
                applySnapshot(tasks: tasks)
            case .completed:
                // Filter completed tasks
                let filteredTasks = tasks.filter { $0.isCompleted }
                applySnapshot(tasks: filteredTasks)
            case .priority(let selectedPriority):
                // Filter by priority
                let filteredTasks = tasks.filter { $0.priority == selectedPriority}
                applySnapshot(tasks: filteredTasks)
            }
                
            }
    func sortTasks() {
         switch currentSortCriteria {
         case .all:
              applySnapshot(tasks: tasks)
         case .creationDate(let ascending):
                // Sort by creation date
            let sortedTasks = tasks.sorted { (task1: TaskToDo, task2: TaskToDo) -> Bool in
            if ascending {
              return task1.creationDate! < task2.creationDate!
            } else {
                return task1.creationDate! > task2.creationDate!
        }
    }
            applySnapshot(tasks: sortedTasks)
          case .completionDate(let ascending):
                // Sort by completion date}
                let sortedTasks = tasks.sorted { (task1: TaskToDo, task2:TaskToDo ) -> Bool in
                if ascending {
                    return task1.completionDate! < task2.completionDate!
                } else {
                    return task1.completionDate! > task2.completionDate!
        }
    }
            applySnapshot(tasks: sortedTasks)
            case .priority(let ascending):
            // Sort by priority
            let sortedTasks = tasks.sorted { task1, task2 in
                if ascending {
                  return task1.priority.rawValue < task2.priority.rawValue
                } else {
                  return task1.priority.rawValue > task2.priority.rawValue
                        }
                }
            applySnapshot(tasks: sortedTasks)
            }
        }
    
    func updateUI() {
        filterTasks()
        sortTasks()
    }
    
    func updateFilterCriteria(newCriteria: FilterCriteria) {
        currentFilterCriteria = newCriteria
        updateUI()
  }
    
    func updateSortCriteria(newCriteria: SortCriteria) {
         currentSortCriteria = newCriteria
         updateUI()
    }
    
    @objc func filterOptionSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentFilterCriteria = .all
            filterTasks()
        case 1:
            currentFilterCriteria = .completed
           filterTasks()
        case 2:
            currentFilterCriteria = .priority(.high)
            filterTasks()
        default:
            break
        }
        updateUI()
    }
    
    @objc func sortByDateButtonTapped() {
        currentSortCriteria = .creationDate(ascending: true) // or false for descending
        updateUI()
    }

    @objc func sortByPriorityButtonTapped() {
        currentSortCriteria = .priority(ascending: false) // or false for descending the important ones are first
        print("buttonTapped") //the tasks with higher priority come first.
        updateUI()
    }

    @objc func sortByCompletionButtonTapped() {
        currentSortCriteria = .completionDate(ascending: true) // or false for descending
        updateUI()
    }
}
            
extension TaskListViewController: DetailControllerDelegate {
    func dataUpdated(for user: TaskToDo) {
        guard (dataSource?.snapshot()) != nil else { return }
        if let objectIndex = tasks.firstIndex(where: { $0.id == user.id }) {
            tasks.remove(at: objectIndex)
            tasks.insert(user, at: objectIndex)
           applySnapshot(tasks: tasks, animatingDifferences: false)
        }
    }
}
extension TaskListViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let task = dataSource?.itemIdentifier(for: indexPath) {
                let detailController = DetailViewController(with: task, description: task.description,  delegate:self)
                navigationController?.pushViewController(detailController, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let task = tasks[sourceIndexPath.row]
            tasks.remove(at: sourceIndexPath.row)
            tasks.insert(task, at: destinationIndexPath.row)
    
            tableView.reloadRows(at: [destinationIndexPath, sourceIndexPath], with: .fade)
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("task deleted")
            deleteTask(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
