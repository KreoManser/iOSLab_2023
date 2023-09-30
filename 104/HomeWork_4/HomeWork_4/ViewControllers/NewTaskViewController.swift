//
//  NewTaskViewController.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 30.09.2023.
//

import UIKit


class NewTaskViewController: UIViewController {

    // MARK: - UI element
    
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
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Приоритет задачи"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let action = UIAction { [weak self] _ in
            
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    private lazy var setTaskPriorityButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBlue
        label.text = "Описание:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New task"
        view.backgroundColor = .white
        addSubViews(subviews: saveButton, taskNameTextField, taskDescriptionTextView, setTaskPriorityButton, priorityLabel, descriptionLabel)
        
        setupTextField()
        setupPriorityButton()
        configureUI()
        hideKeyboardWhenTappedAround()
    }
}

extension NewTaskViewController: UITextFieldDelegate {
    // MARK: - add subviews
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
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
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
            taskDescriptionTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -5)
            
            
        ])
    }
    
    // MARK: - setup priority button
    private func setupPriorityButton() {
        
        let setLowPriorityActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let setMediumPriorityActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let setHighPriorityActionClosure = { (action: UIAction) in
            print(action.title)
        }
        
        setTaskPriorityButton.menu = UIMenu(title: "Приоритет задачи".uppercased(), children: [
            UIAction(title: "Низкий", state: .on, handler: setLowPriorityActionClosure),
            UIAction(title: "Средний", handler: setMediumPriorityActionClosure),
            UIAction(title: "Высокий", handler: setHighPriorityActionClosure)
        ])
        
        setTaskPriorityButton.showsMenuAsPrimaryAction = true
        setTaskPriorityButton.changesSelectionAsPrimaryAction = true
    }
}

extension NewTaskViewController {
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
