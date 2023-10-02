//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Faki Doosuur Doris on 01.10.2023.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func dataUpdated(for task: TaskToDo)
}

class DetailViewController: UIViewController {
    
    private weak var delegate: DetailControllerDelegate?
    private var taskDescription: String?
    private var currentTask: TaskToDo!
    
    private var titleLabel: UITextField = {
        let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var descriptionText: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTextView
    }()
    
    private lazy var saveButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    init(with task: TaskToDo, description: String, delegate: DetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
            self.currentTask = task
            self.taskDescription = description
            self.delegate = delegate
        titleLabel.text = currentTask.tasks
        descriptionText.text = currentTask.description
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionText)
        self.view.addSubview(saveButton)
        configureUI()
    }
    
    func configureUI() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            saveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    @objc private func saveTask() {
        if var editedTask = currentTask {
            editedTask.tasks = titleLabel.text ?? ""
            editedTask.description = descriptionText.text
            currentTask = editedTask
            delegate?.dataUpdated(for: editedTask)
        }
        titleLabel.isEnabled = false
        descriptionText.isEditable = false
    }
}
