//
//  ViewController.swift
//  ToDoList
//
//  Created by Rustem on 02.10.2023.
//

import UIKit

class ViewController: UIViewController {
    private let contactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do smth", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    enum TableViewSections {
        case default1
    }
    
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.estimatedRowHeight = 60
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tasks.append(MyTask(title: "Мое первое задание", description: "закончить эту пое", priority: 3))
        tasks.append(MyTask(title: "Мое второе задание", description: "поспать", priority: 2))
        addSubViews(tasksTableView)
        setupViews()
        setConstraints()
        setupDataSource()
    }
    
    @objc func addTapped(){
        print("Создать задачу")
    }
    
    var tasks: [MyTask] = []
    
    var dataSource: UITableViewDiffableDataSource<TableViewSections, MyTask>?
    
    private func setupViews (){
        createCustomNavigationBar()
        
        let customTitleView = createCustomTitleView(
            contactName: "Список задач"
        )
        
        let creationTimeEarlyFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate < $1.creationDate }
            self.updateData(with: self.tasks, animated: true)
        }
        
        let creationTimeLateFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { $0.creationDate > $1.creationDate }
            self.updateData(with: self.tasks, animated: true)
        }
        
        let descendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { (task1: MyTask, task2: MyTask) in
                if task1.priority > task2.priority {
                    return true
                }
                else if task1.priority < task2.priority {
                    return false
                }
                else {
                    return false
                }
            }
            self.updateData(with: self.tasks, animated: true)
        }
        
        let ascendingPriorityFilterActionClosure = { (action: UIAction) in
            self.tasks.sort { (task1: MyTask, task2: MyTask) in
                if task1.priority < task2.priority {
                    return true
                }
                else if task1.priority > task2.priority {
                    return false
                }
                else {
                    return false
                }
            }
            self.updateData(with: self.tasks, animated: true)
        }

        let sortMenu = UIMenu(title: "СОРТИРОВКА", children: [
            UIAction(title: "Сначала старые", handler: creationTimeEarlyFilterActionClosure),
            UIAction(title: "Сначала новые", handler: creationTimeLateFilterActionClosure),
            UIAction(title: "По возрастанию приоритета", handler: descendingPriorityFilterActionClosure),
            UIAction(title: "По убыванию приоритета", handler: ascendingPriorityFilterActionClosure)
        ])
        
        let audioRightButton = UIBarButtonItem(title: "Menu", image: nil, primaryAction: nil, menu: sortMenu)
        audioRightButton.tintColor = .orange
        
        navigationItem.rightBarButtonItem = audioRightButton
        let addAction = UIAction { _ in
            self.tasks.append(MyTask(title: "задание", description: "ыыыы", priority: 1))
            self.updateData(with: self.tasks, animated: false)
            
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.titleView = customTitleView
    }
    
    private func addSubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
}

extension ViewController: DetailViewDelegate{
    func didPressSaveButton(task: MyTask) {
        let currentTask = task
        if let indexToUpdate = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: indexToUpdate)
            tasks.insert(contentsOf: [currentTask], at: indexToUpdate)
        }
        updateData(with: tasks, animated: false)
        navigationController?.popViewController(animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tasksTableView, cellProvider: { tableView, indexPath, task in
            let cell = self.tasksTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
            cell.configureCell(with: task)
            return cell
        })
        self.updateData(with: self.tasks, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = dataSource?.itemIdentifier(for: indexPath){
            navigationController?.pushViewController(DetailViewController(with: task, delegate: self), animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func updateData(with tasks: [MyTask], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, MyTask>()
        snapshot.appendSections([.default1])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}

