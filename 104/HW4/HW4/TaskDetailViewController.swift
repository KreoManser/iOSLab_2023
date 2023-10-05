//
//  TaskDetailViewController.swift
//  HW4
//
//  Created by Kseniya Skvortsova on 05.10.2023.
//

import UIKit

protocol TaskDetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class TaskDetailViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startingDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endingDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private weak var delegate: TaskDetailControllerDelegate?
    private var currentTask: Task!
    
    init(with task: Task, delegate: TaskDetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentTask = task
        self.delegate = delegate
        
        initiateTask()
    }
    
    func initiateTask(){
        titleLabel.text=currentTask.name
        subtitleLabel.text=currentTask.subtitle
        startingDateLabel.text = "From " + currentTask.startingDate
        endingDateLabel.text="To "+currentTask.endingDate
        typeLabel.text="Type: "+currentTask.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupLayout()
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            let nextVC = EditDetailViewController(with: self.currentTask, delegate: self)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        navigationItem.title = currentTask.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .edit, primaryAction: editAction, menu: nil)
    }
    
    func setupLayout() {
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, startingDateLabel, endingDateLabel, typeLabel, subtitleLabel])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing=5
        mainStackView.setCustomSpacing(20, after: titleLabel)
        mainStackView.setCustomSpacing(20, after: endingDateLabel)
        mainStackView.setCustomSpacing(20, after: typeLabel)
        
        addSubviews(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension TaskDetailViewController: EditDetailControllerDelegate {
    func dataUpdated(for task: Task) {
        self.delegate?.dataUpdated(for: task)
        
//        currentTask=task
        
        self.navigationController?.popViewController(animated: true)
    }
}
