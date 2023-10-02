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
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Отсортировать по дате", handler: { (_) in
                }),
                UIAction(title: "Отсортировать по всему остальному", attributes: .disabled, handler: { (_) in
                }),
                UIAction(title: "Очистить", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                    self.tasks.removeAll()
                    self.updateData(with: self.tasks)
                })
            ]
        }
        
        var demoMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        let audioRightButton = UIBarButtonItem(title: "Menu", image: nil, primaryAction: nil, menu: demoMenu)
        audioRightButton.tintColor = .orange
        
        navigationItem.rightBarButtonItem = audioRightButton
        let addAction = UIAction { _ in
            self.tasks.append(MyTask(title: "задание", description: "", priority: 1))
            self.updateData(with: self.tasks)
            
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
    
    @objc private func audioRightButtonTapped() {
        print("audioRightButtonTapped")
    }
}

extension ViewController: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tasksTableView, cellProvider: { tableView, indexPath, task in
            let cell = self.tasksTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as! UserTableViewCell
            cell.configureCell(with: task)
            return cell
        })
        self.updateData(with: self.tasks)
    }
    
    private func updateData(with tasks: [MyTask]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, MyTask>()
        snapshot.appendSections([.default1])
        snapshot.appendItems(tasks)
        dataSource?.apply(snapshot)
    }
}

