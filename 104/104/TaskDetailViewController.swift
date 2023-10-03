//
//  TaskDetailViewController.swift
//  104
//
//  Created by Dmitry on 02.10.2023.
//

import UIKit

protocol TaskDetailScreenDelegate: AnyObject {
    func didFinishEditTask(with: Task)
}

class TaskDetailViewController: UIViewController {
    
    private lazy var nameTaskTextView: UITextView = {
        let nameTextView = UITextView()
        nameTextView.layer.cornerRadius = 10
        nameTextView.font = UIFont.systemFont(ofSize: 30)
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        nameTextView.textAlignment = .left
        nameTextView.backgroundColor = .systemGray6
        return nameTextView
    }()
    
    private lazy var descriptionTaskTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textAlignment = .left
        textView.backgroundColor = .systemGray6
        return textView
    }()
    
    private var task: Task!
    
    private weak var delegate: TaskDetailScreenDelegate?
    
    private lazy var saveButton: UIButton = {
        let action = UIAction { _ in
            let updatedTask = Task(id: self.task.id, name: self.nameTaskTextView.text, description: self.descriptionTaskTextView.text)
            self.delegate?.didFinishEditTask(with: updatedTask)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .gray(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    
    init(with: Task, delegate: TaskDetailScreenDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.task = with
        self.delegate = delegate
        configureViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setUpConstraints()
    }
    
    func configureViewController() {
        nameTaskTextView.text = task.name
        descriptionTaskTextView.text = task.description
    }
}

extension TaskDetailViewController {
    
    private func addSubviews() {
        view.addSubview(nameTaskTextView)
        view.addSubview(saveButton)
        view.addSubview(descriptionTaskTextView)
    }
    
    private func setUpConstraints() {
        setUpNameTaskLabelConstraints()
        setUpSaveButtonConstraints()
        setUpDescriptionTextViewConstraints()
    }
    
    private func setUpNameTaskLabelConstraints() {
        NSLayoutConstraint.activate([
            nameTaskTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameTaskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTaskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTaskTextView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setUpSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setUpDescriptionTextViewConstraints() {
        NSLayoutConstraint.activate([
            descriptionTaskTextView.topAnchor.constraint(equalTo: nameTaskTextView.bottomAnchor, constant: 20),
            descriptionTaskTextView.leadingAnchor.constraint(equalTo: nameTaskTextView.leadingAnchor),
            descriptionTaskTextView.trailingAnchor.constraint(equalTo: nameTaskTextView.trailingAnchor),
            descriptionTaskTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20),
        ])
    }
}
