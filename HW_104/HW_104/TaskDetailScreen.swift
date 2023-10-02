//
//  TaskDetailScreen.swift
//  HW_104
//
//  Created by Азат Зиганшин on 02.10.2023.
//

import UIKit

protocol TaskDetailScreenDelegate: AnyObject {
    func dataUpdated(task: Task)
}

class TaskDetailScreen: UIViewController {

    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название задачи"
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.text = "gfgfdbdf"
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let action = UIAction { _ in
            let updatedTask = Task(id: self.currentTask.id, title: self.titleTextField.text ?? "Новая задача", description: self.descriptionTextView.text)
            self.delegate?.dataUpdated(task: updatedTask)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: TaskDetailScreenDelegate?
    private var currentTask: Task!
    
    init(with task: Task, delegate: TaskDetailScreenDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentTask = task
        self.delegate = delegate
        
        titleTextField.text = task.title
        descriptionTextView.text = task.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Задача"
        setupLayout()   
    }

    func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            descriptionTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
}
