//
//  TaskDeteilViewController.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 30.09.2023.
//

import UIKit
protocol TaskUpdatesDelegate: AnyObject {
    func updateTask(task: ToDoTask)
    func removeTask(task: ToDoTask)
}
class TaskDetailViewController: UIViewController {
    
    // MARK: - UITextFields
    private lazy var taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.delegate = self
        return textField
    }()
    
    // MARK: - UITextViews
    private lazy var taskDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black
        textView.backgroundColor = .white
        return textView
    }()
    
    // MARK: - UILabels
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Приоритет задачи"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.text = "Описание"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - UIButtons
    private lazy var setTaskPriorityButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var taskIsCompletedButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let action = UIAction { _ in
            
            let alert = UIAlertController(title: "", message: "Удалить задачу?".uppercased(), preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
                self.delegate?.removeTask(task: self.currentTask) }))
            
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            
            self.present(alert, animated: true)
        }
        
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("удалить", for: .normal)
        return button
    }()
    
    private lazy var saveСhangesButton: UIButton = {
        let action = UIAction { _ in
            self.currentTask.name = self.taskNameTextField.text ?? ""
            self.currentTask.description = self.taskDescriptionTextView.text ?? ""
            self.delegate?.updateTask(task: self.currentTask)
        }
        
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить изменения", for: .normal)
        return button
    }()
    
    // MARK: - variables
    private weak var delegate: TaskUpdatesDelegate?
    private var currentTask: ToDoTask!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews(subviews: taskNameTextField, taskDescriptionTextView, setTaskPriorityButton, descriptionLabel, priorityLabel, saveСhangesButton, deleteButton, taskIsCompletedButton)
        setupTextField()
        setupPopUpButtons()
        configureUI()
        hideKeyboardWhenTappedAround()
    }
    
    init(task: ToDoTask, delegate: TaskUpdatesDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        currentTask = task
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskDetailViewController {
    private func addSubViews(subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    // MARK: - setup textField placeHolder
    private func setupTextField() {
        taskNameTextField.attributedPlaceholder = NSAttributedString(string: "Название задачи", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
    }
    
    // MARK: - func configure UI
    private func configureUI() {
        
        NSLayoutConstraint.activate([
            
            taskNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            taskNameTextField.heightAnchor.constraint(equalTo: setTaskPriorityButton.heightAnchor),
            
            priorityLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 10),
            priorityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            setTaskPriorityButton.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: 5),
            setTaskPriorityButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            setTaskPriorityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: setTaskPriorityButton.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            taskDescriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            taskDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            taskDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            deleteButton.topAnchor.constraint(equalTo: taskDescriptionTextView.bottomAnchor, constant: 10),
            deleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2.2),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            taskIsCompletedButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2.2),
            taskIsCompletedButton.topAnchor.constraint(equalTo: taskDescriptionTextView.bottomAnchor, constant: 10),
            taskIsCompletedButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            saveСhangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveСhangesButton.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10),
            saveСhangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveСhangesButton.heightAnchor.constraint(equalTo: deleteButton.heightAnchor)
        ])
    }
    
    // MARK: - configureFields
    private func configureFields() {
        self.taskNameTextField.text = currentTask.name
        self.taskDescriptionTextView.text = currentTask.description
    }
}

// MARK: - UITextFieldDelegate implementation
extension TaskDetailViewController: UITextFieldDelegate {
    // MARK: - textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskNameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - hide keyboard when tapped around
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension TaskDetailViewController {
    // MARK: - setup popUp buttons
    private func setupPopUpButtons() {
        
        // MARK: - setup priority button
        
        setTaskPriorityButton.menu = setUIMenuPriority()
        
        setTaskPriorityButton.showsMenuAsPrimaryAction = true
        setTaskPriorityButton.changesSelectionAsPrimaryAction = true
        
        // MARK: - setup taskIsCompletedButton
        
        taskIsCompletedButton.menu = setUIMenuIsCompleted()
        
        taskIsCompletedButton.showsMenuAsPrimaryAction = true
        taskIsCompletedButton.changesSelectionAsPrimaryAction = true
        
    }
    
    ///нереальные костыли
    // MARK: - setUIMenuPriority
    private func setUIMenuPriority() -> UIMenu{
        let setLowPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .low
        }
        
        let setMediumPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .medium
        }
        
        let setHighPriorityActionClosure = { (action: UIAction) in
            self.currentTask.priority = .high
        }
        
        switch currentTask.priority {
        case .low:
            return UIMenu(title: "Приоритет задачи".uppercased(), children: [
                UIAction(title: "Низкий", state: .on, handler: setLowPriorityActionClosure),
                UIAction(title: "Средний", handler: setMediumPriorityActionClosure),
                UIAction(title: "Высокий", handler: setHighPriorityActionClosure)
            ])
        case .medium:
            return UIMenu(title: "Приоритет задачи".uppercased(), children: [
                UIAction(title: "Низкий", handler: setLowPriorityActionClosure),
                UIAction(title: "Средний", state: .on, handler: setMediumPriorityActionClosure),
                UIAction(title: "Высокий", handler: setHighPriorityActionClosure)
            ])
        case .high:
            return UIMenu(title: "Приоритет задачи".uppercased(), children: [
                UIAction(title: "Низкий", handler: setLowPriorityActionClosure),
                UIAction(title: "Средний", handler: setMediumPriorityActionClosure),
                UIAction(title: "Высокий", state: .on, handler: setHighPriorityActionClosure)
            ])
        }
    }
    
    // MARK: - setUIMenuIsCompleted
    private func setUIMenuIsCompleted() -> UIMenu{
        let setTaskIsCompletedActionClosure = { (action: UIAction) in
            self.currentTask.isCompleted = true
        }
        
        let setTaskIsNotCompletedActionClosure = { (action: UIAction) in
            self.currentTask.isCompleted = false
        }
        
        switch currentTask.isCompleted {
        case false:
            return UIMenu(title: "Статус задачи".uppercased(), children: [
                UIAction(title: "Не выполнена", state: .on, handler: setTaskIsNotCompletedActionClosure),
                UIAction(title: "Выполнена", handler: setTaskIsCompletedActionClosure)
            ])
        case true:
            return UIMenu(title: "Статус задачи".uppercased(), children: [
                UIAction(title: "Не выполнена", handler: setTaskIsNotCompletedActionClosure),
                UIAction(title: "Выполнена", state: .on, handler: setTaskIsCompletedActionClosure)
            ])
        }
    }
}
