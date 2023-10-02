//
//  TaskDetailScreenViewController.swift
//  4HW
//
//  Created by Ruslan on 02.10.2023.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func dataUpdate(for task: Task)
}

class TaskDetailScreenViewController: UIViewController, UITextViewDelegate {

    private lazy var titleView: UITextView = {
        let title = UITextView()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 15)
        
        return title
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.backgroundColor = .systemOrange
        description.layer.cornerRadius = 10
        description.delegate = self
        description.clipsToBounds = true
        description.font = UIFont.systemFont(ofSize: 12)
        return description
    }()
    
    private lazy var status: UITextView = {
        let status = UITextView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 9)
        return status
    }()
    
    private lazy var dateOfCreation: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .dateAndTime
        date.tintColor = .systemOrange
        
        return date
    }()
    
    private lazy var completionDate: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .dateAndTime
        date.tintColor = .systemOrange
        return date
    }()
    
    private lazy var createDataLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Старт: "
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var completDataLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Конец: "
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    
    weak var delegate: DetailControllerDelegate?
    var currentTask: Task!
    
    lazy var button: UIButton = {
        let action = UIAction { _ in
            
            let updatedTitle = self.titleView.text ?? ""
            let updatedDescription = self.descriptionTextView.text ?? ""
            let updatedStatus = self.status.text ?? ""
            let updatedDateOfCreation = self.dateOfCreation.date
            let updatedCompletionDate = self.completionDate.date

            let updateTask = Task(
                id: self.currentTask.id,
                title: updatedTitle,
                description: updatedDescription,
                status: updatedStatus,
                dateOfCreation: updatedDateOfCreation,
                completionDate: updatedCompletionDate
            )
            self.delegate?.dataUpdate(for: updateTask)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
 
    
    
    init(with task: Task, delegate: DetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.currentTask = task
        self.delegate = delegate
        titleView.text = currentTask.title
        status.text = currentTask.status
        descriptionTextView.text = currentTask.description
        completionDate.date = currentTask.completionDate
        dateOfCreation.date = currentTask.dateOfCreation
        setupLayuotCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupLayuotCell() {
        view.addSubview(titleView)
        view.addSubview(descriptionTextView)
        view.addSubview(status)
        view.addSubview(dateOfCreation)
        view.addSubview(completionDate)
        view.addSubview(completDataLabel)
        view.addSubview(createDataLabel)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleView.widthAnchor.constraint(equalToConstant: 100),
            titleView.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            status.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            status.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            status.widthAnchor.constraint(equalToConstant: 85),
            status.heightAnchor.constraint(equalToConstant: 20),
            
            createDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            createDataLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            
            dateOfCreation.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            dateOfCreation.leadingAnchor.constraint(equalTo: createDataLabel.trailingAnchor, constant: 10),
            
            completDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            completDataLabel.topAnchor.constraint(equalTo: createDataLabel.bottomAnchor, constant: 25),
            
            completionDate.topAnchor.constraint(equalTo: dateOfCreation.bottomAnchor, constant: 10),
            completionDate.leadingAnchor.constraint(equalTo: completDataLabel.trailingAnchor, constant: 10),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }

}
