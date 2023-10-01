//
//  NewTaskViewController.swift
//  Homework4
//
//  Created by kerik on 01.10.2023.
//

import UIKit

protocol NewTaskDelegate: AnyObject {
    func addNewTask(with newTask: Task)
}

class NewTaskViewController: UIViewController {
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
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
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
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .black
        textView.backgroundColor = .systemGray6
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let action = UIAction { [weak self] _ in
            var newTask = Task(title: self?.taskNameTextField.text ?? "", description: self?.descriptionTextView.text ?? "", priority: self?.taskPriority ?? .low)
            self?.delegate?.addNewTask(with: newTask)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    var taskPriority: Priority = .low
        
    private weak var delegate: NewTaskDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Новая задача"
        view.backgroundColor = .white
        addSubViews(subviews: taskTitleLabel, taskNameTextField, priorityLabel, prioritySegmentedControl, descriptionLabel, descriptionTextView, saveButton)
        setupPriorityButton()
        setLayout()
    }
    
    init( delegate: NewTaskDelegate? = nil) {
            super.init(nibName: nil, bundle: nil)
            self.delegate = delegate
        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskViewController {
    private func addSubViews(subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    private func setupPriorityButton() {
            let setLowPriorityActionClosure = { (action: UIAction) in
                self.taskPriority = .low
                print(action.title)
            }
            
            let setMediumPriorityActionClosure = { (action: UIAction) in
                self.taskPriority = .medium
                print(action.title)
            }
            
            let setHighPriorityActionClosure = { (action: UIAction) in
                self.taskPriority = .high
                print(action.title)
            }
        
        prioritySegmentedControl.insertSegment(action: UIAction(title: "Низкий", handler: setLowPriorityActionClosure), at: 0, animated: false)
        prioritySegmentedControl.insertSegment(action: UIAction(title: "Средний", handler: setMediumPriorityActionClosure), at: 1, animated: false)
        prioritySegmentedControl.insertSegment(action: UIAction(title: "Высокий", handler: setHighPriorityActionClosure), at: 2, animated: false)
        }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            taskTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            taskNameTextField.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 5),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            priorityLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 20),
            priorityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            prioritySegmentedControl.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: 5),
            prioritySegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            prioritySegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: prioritySegmentedControl.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -5)
        ])
    }
}

extension NewTaskViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskNameTextField.resignFirstResponder()
        return true
    }
}
