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
            tasks.append(ToDoTask(name: "sfsdf qeqewqesdfssdfsdfssfsdfsdfsdfTask", description: "pohuiadlaldladapdlaldaldafkjnskfnkjskjnkasn"))
        }
        
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
            self.tasks.append(ToDoTask(name: "new Task", description: "dad"))
            self.updateData(with: self.tasks)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)

        navigationItem.rightBarButtonItem = cusmotButton
    }
    
    // MARK: - Func setup filter button
    private func setupFilterButton() {
        let creationTimeFilterActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let endTimeFilterActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let descendingPriorityFilterActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let ascendingPriorityFilterActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        
        customBarButtonItem.menu = UIMenu(title: "Сортировка".uppercased(), children: [
            UIAction(title: "По дате создания", state: .on, handler: creationTimeFilterActionClosure),
            UIAction(title: "По дате выполнения", handler: endTimeFilterActionClosure),
            UIAction(title: "По приоритету max", handler: ascendingPriorityFilterActionClosure),
            UIAction(title: "По приоритету min", handler: descendingPriorityFilterActionClosure)
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
