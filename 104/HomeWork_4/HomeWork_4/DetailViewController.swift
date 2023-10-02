//
//  DetailViewController.swift
//  HomeWork_4
//
//  Created by Нияз Ризванов on 02.10.2023.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func updateData(for task: Task)
    func deleteCase(for task: Task)
}


class DetailViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название задачи"
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.textColor = .black
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Здача"
        textField.textColor = .black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .systemGray4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Описание"
        textField.textColor = .black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .systemGray4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let action = UIAction { _ in
            let updateUser = Task(id: self.currentTask.id,
                                  title: self.titleTextField.text ?? "",
                                  description: self.descriptionTextField.text ?? "")
            self.delegate?.updateData(for: updateUser)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let action = UIAction { _ in
            let updateUser = Task(id: self.currentTask.id,
                                  title: self.titleTextField.text ?? "",
                                  description: self.descriptionTextField.text ?? "")
            self.delegate?.deleteCase(for: updateUser)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(saveButton)
        view.addSubview(deleteButton)
        
        setupLayout()
    }
    
    private weak var delegate: DetailControllerDelegate?
    private var currentTask: Task!
    
    init(task: Task, delegate: DetailControllerDelegate?){
        super.init(nibName: nil, bundle: nil)
        self.currentTask = task
        self.delegate = delegate
        titleTextField.text = task.title
        descriptionTextField.text = task.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let screenWeight = UIScreen.main.bounds.width
        let textFieldWeight = screenWeight * 0.97
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 5),
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionTextField.widthAnchor.constraint(equalToConstant: textFieldWeight),
            
            saveButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor,constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor,constant: 10),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
