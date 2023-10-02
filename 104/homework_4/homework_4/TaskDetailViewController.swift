//
//  TaskDetailViewController.swift
//  homework_4
//
//  Created by Кирилл Щёлоков on 02.10.2023.
//

import UIKit

protocol TaskDetailViewControllerDelegate: AnyObject {
    func didUpdateTask(task: Task)
}

class TaskDetailViewController: UIViewController, UITextViewDelegate {

    // MARK: Variables
    
    private var task: Task
    weak var delegate: TaskDetailViewControllerDelegate?
    
    lazy var taskTextView : UITextView = {
        let taskTextView = UITextView()
        return taskTextView
    }()
    
    lazy var descriptionTextView : UITextView = {
        let descriptionTextView = UITextView()
        return descriptionTextView
    }()
    
    lazy var taskTitleLable : UILabel = {
        let taskTitleLable = UILabel()
        return taskTitleLable
    }()
    
    lazy var descriptionTitleLable : UILabel = {
        let descriptionTitleLable = UILabel()
        return descriptionTitleLable
    }()
    
    lazy var creationDateTitleLable : UILabel = {
        let creationDateTitleLable = UILabel()
        return creationDateTitleLable
    }()
    
    lazy var creationDateLable : UILabel = {
        let creationDateLable = UILabel()
        return creationDateLable
    }()
    
    lazy var completionDateTitleLable : UILabel = {
        let completionDateTitleLable = UILabel()
        return completionDateTitleLable
    }()
    
    lazy var completionDateLable : UILabel = {
        let completionDateLable = UILabel()
        return completionDateLable
    }()
    
    lazy var priorityTitleLable : UILabel = {
        let priorityTitleLable = UILabel()
        return priorityTitleLable
    }()
    
    lazy var priorityLable : UILabel = {
        let priorityLable = UILabel()
        return priorityLable
    }()
    
    lazy var completionButton : UIButton = {
        let completionButton = UIButton()
        return completionButton
    }()
    
    lazy var addPriorityButton : UIButton = {
        let addPriorityButton = UIButton()
        return addPriorityButton
    }()
    
    lazy var decreasePriorityButton : UIButton = {
        let decreasePriorityButton = UIButton()
        return decreasePriorityButton
    }()
        
    init(task: Task) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetUp

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
        configure(with: task)
        setupNavigationItems()
    }
    
    private func setUp(){
        setUptaskTextView()
        setUpDescriptionTextView()
        setUpTaskTitleLable()
        setUpDescriptionTitleLable()
        setUpCreationDateTitleLable()
        setUpCreationDateLable()
        setUpCompletionDateTitleLable()
        setUpCompletionDateLable()
        setUpPriorityTitleLable()
        setUpPriorityLable()
        setUpCompletionButton()
        setUpAddPriorityButton()
        setUpDecreasePriorityButton()
    }

    
    private func setUptaskTextView(){
        configureTextView(with: taskTextView)

        NSLayoutConstraint.activate([
            taskTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            taskTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTextView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUpDescriptionTextView(){
        configureTextView(with: descriptionTextView)

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setUpTaskTitleLable() {
        view.addSubview(taskTitleLable)
        
        taskTitleLable.text = "Задача:"
        taskTitleLable.textColor = .black
        
        taskTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskTitleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            taskTitleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    private func setUpDescriptionTitleLable() {
        view.addSubview(descriptionTitleLable)
        
        descriptionTitleLable.text = "Описание:"
        descriptionTitleLable.textColor = .black
        
        descriptionTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTitleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            descriptionTitleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpCreationDateTitleLable() {
        view.addSubview(creationDateTitleLable)
        
        creationDateTitleLable.text = "Дата создания:"
        creationDateTitleLable.textColor = .black
        
        creationDateTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creationDateTitleLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -310),
            creationDateTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    private func setUpCreationDateLable(){
        view.addSubview(creationDateLable)
        creationDateLable.textColor = .black
        
        creationDateLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creationDateLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -310),
            creationDateLable.leadingAnchor.constraint(equalTo: creationDateTitleLable.trailingAnchor, constant: 10),
        ])
    }
    
    private func setUpCompletionDateTitleLable() {
        view.addSubview(completionDateTitleLable)
        
        completionDateTitleLable.text = "Дата выполнения:"
        completionDateTitleLable.textColor = .black
        
        completionDateTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completionDateTitleLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280),
            completionDateTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    private func setUpCompletionDateLable() {
        view.addSubview(completionDateLable)
        completionDateLable.textColor = .black
        
        completionDateLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completionDateLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280),
            completionDateLable.leadingAnchor.constraint(equalTo: completionDateTitleLable.trailingAnchor, constant: 10),
        ])
    }
    
    
    private func setUpPriorityTitleLable() {
        view.addSubview(priorityTitleLable)
        
        priorityTitleLable.text = "Приоритет:"
        priorityTitleLable.textColor = .black
        
        priorityTitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityTitleLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            priorityTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    private func setUpPriorityLable() {
        view.addSubview(priorityLable)
        priorityLable.textColor = .black
        
        priorityLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priorityLable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            priorityLable.leadingAnchor.constraint(equalTo: priorityTitleLable.trailingAnchor, constant: 10),
        ])
    }
    
    private func setUpCompletionButton() {
        view.addSubview(completionButton)
        
        completionButton.backgroundColor = .white
        completionButton.layer.cornerRadius = 10
        completionButton.layer.borderColor = UIColor.black.cgColor
        completionButton.layer.borderWidth = 1
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -280),
            completionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            completionButton.heightAnchor.constraint(equalToConstant: 20),
            completionButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let completionButtonAction = UIAction { [self] _ in
            if completionButton.backgroundColor == .white {
                completionButton.backgroundColor = .gray
                completionDateLable.text = Date().description.replacingOccurrences(of: " +0000", with: "")
            } else {
                completionButton.backgroundColor = .white
                completionDateLable.text = "Не завершено"
            }
        }
        
        completionButton.addAction(completionButtonAction, for: .touchUpInside)
    }
    
    private func setUpAddPriorityButton(){
        view.addSubview(addPriorityButton)
        
        addPriorityButton.setImage(UIImage(named: "plusImage"), for: .normal)
        
        addPriorityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPriorityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            addPriorityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -180),
            addPriorityButton.heightAnchor.constraint(equalToConstant: 20),
            addPriorityButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let addPriorityButtonAction = UIAction {[self] _ in
            priorityLable.text = String(Int(priorityLable.text!)! + 1)
        }
        
        addPriorityButton.addAction(addPriorityButtonAction, for: .touchUpInside)
    }
    
    private func setUpDecreasePriorityButton(){
        view.addSubview(decreasePriorityButton)
        
        decreasePriorityButton.setImage(UIImage(named: "minusImage"), for: .normal)
        
        decreasePriorityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            decreasePriorityButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            decreasePriorityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -205),
            decreasePriorityButton.heightAnchor.constraint(equalToConstant: 20),
            decreasePriorityButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let decreasePriorityButtonAction = UIAction { [self]_ in
            priorityLable.text = String(Int(priorityLable.text!)! - 1)
        }
        
        decreasePriorityButton.addAction(decreasePriorityButtonAction, for: .touchUpInside)
    }
    
    
    private func configureTextView(with textView: UITextView){
        view.addSubview(textView)

        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 20
    }
    
    private func configure(with task: Task) {
        taskTextView.text = task.title
        descriptionTextView.text = task.description
        creationDateLable.text = task.creationDate.description.replacingOccurrences(of: " +0000", with: "")
        completionDateLable.text = task.completionDate?.description.replacingOccurrences(of: " +0000", with: "") ?? "Не завершено"
        priorityLable.text = String(task.priority ?? 0)
    }

    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        navigationItem.title = "\(task.title)"
    }
    
    // MARK: Actions

    @objc
    private func saveTask() {
        var date: Date?
        if completionDateLable.text != "Не завершено" {
            date = Date()
        }
        
        let updatedTask = Task(id: UUID(), title: taskTextView.text ?? "", description: descriptionTextView.text ?? "", creationDate: task.creationDate,
                               completionDate: date, priority: Int(priorityLable.text!) ?? 0)
        delegate?.didUpdateTask(task: updatedTask)
        navigationController?.popViewController(animated: true)
    }
    
    
}
