//
//  TaskDetailViewController.swift
//  Homework4
//
//  Created by kerik on 03.10.2023.
//

import UIKit
protocol TaskUpdatesDelegate: AnyObject {
    func updateTask(task: Task)
    func removeTask(task: Task)
}

class TaskDetailViewController: UIViewController {
    private weak var delegate: TaskUpdatesDelegate?
    private var currentTask: Task!
    
    private lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Задача"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Приоритет задачи"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .systemGray6
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.text = "Описание"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .black
        textView.backgroundColor = .systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    private lazy var deleteButton: UIButton = {
        let action = UIAction { _ in
            self.delegate?.removeTask(task: self.currentTask)
        }
            
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemRed, for: .normal)
        button.tintColor = .systemGray6
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let action = UIAction { _ in
            self.currentTask.title = self.taskNameTextField.text ?? ""
            self.currentTask.description = self.descriptionTextView.text ?? ""
            self.delegate?.updateTask(task: self.currentTask)
        }
            
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews(subviews: taskTitleLabel, taskNameTextField, priorityLabel, prioritySegmentedControl, descriptionLabel, descriptionTextView, saveButton, deleteButton)
        setupPriorityButton()
        setLayout()
    }
    
    init(task: Task, delegate: TaskUpdatesDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        currentTask = task
        setFields()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskDetailViewController {
    private func addSubViews(subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func setFields() {
        self.taskNameTextField.text = currentTask.title
        self.descriptionTextView.text = currentTask.description
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            taskTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 5),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            priorityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priorityLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 20),
            
            prioritySegmentedControl.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: 5),
            prioritySegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            prioritySegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionTextView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: prioritySegmentedControl.bottomAnchor, constant: 20)
        ])
    }
}

extension TaskDetailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskNameTextField.resignFirstResponder()
        return true
    }
}

extension TaskDetailViewController {
    private func setupPriorityButton() {
        let setLowPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .low
        }
        
        let setMediumPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .medium
        }
            
        let setHighPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .high
        }
        
        prioritySegmentedControl.insertSegment(action: UIAction(title: "low", handler: setLowPriorityActionClosure), at: 0, animated: false)
        prioritySegmentedControl.insertSegment(action: UIAction(title: "medium", handler: setMediumPriorityActionClosure), at: 1, animated: false)
        prioritySegmentedControl.insertSegment(action: UIAction(title: "high", handler: setHighPriorityActionClosure), at: 2, animated: false)
    }
}
