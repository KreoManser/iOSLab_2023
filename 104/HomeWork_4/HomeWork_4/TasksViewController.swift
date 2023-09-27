//
//  TasksViewController.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 27.09.2023.
//

import UIKit

// MARK: - TasksViewController
class TasksViewController: UIViewController {
    // MARK: - UI elements
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Заметки"
        addSubViews(tasksTableView)
        configureUI()
    }
}

// MARK: - extencion TasksViewController
extension TasksViewController {
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
}
