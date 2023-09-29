//
//  TasksViewController.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 27.09.2023.
//

import UIKit

// MARK: - TasksViewController
class ToDoTasksViewController: UIViewController {
    // MARK: - UI elements
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var customBarButtonItem: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "FilterButtonImg"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews(tasksTableView)
        configureUI()
        setupNavigationBar()
    }
}

// MARK: - extencion TasksViewController
extension ToDoTasksViewController {
    private func addSubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupNavigationBar() {
        self.title = "To Do"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: nil)
        
        let cusmotButton = UIBarButtonItem(customView: customBarButtonItem)
        cusmotButton.customView?.widthAnchor.constraint(equalToConstant: 17).isActive = true
        cusmotButton.customView?.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        navigationItem.rightBarButtonItems =
        [
            UIBarButtonItem(systemItem: .edit, primaryAction: nil),
            cusmotButton
        ]
    }
}
