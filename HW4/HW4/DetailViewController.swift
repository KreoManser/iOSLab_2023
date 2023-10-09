//
//  DetailViewController.swift
//  HW4
//
//  Created by Alina on 09.10.2023.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class DetailViewController: UIViewController {
    
    private weak var delegate: DetailControllerDelegate?

    lazy var titleTextField: UITextField = {
       
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 28)
        return text
    }()
    
    lazy var descriptionTextField: UITextField = {
       
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 28)
        return text
    }()
    
    lazy var okButton: UIButton = {
            let action = UIAction { _ in
                let updatedTask = Task(id: self.currentTask.id, title: self.titleTextField.text ?? "" , description: self.descriptionTextField.text ?? "")
                self.delegate?.dataUpdated(for: updatedTask)
                self.navigationController?.popViewController(animated: true)
            }
            let button = UIButton(type: .system, primaryAction: action)
            button.setTitle("OK", for: .normal)
            button.backgroundColor = .gray
            button.tintColor = .black
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }()
    

    private var currentTask: Task!
    
    init(with task: Task, delegate: DetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentTask = task
        self.delegate = delegate
        
        titleTextField.text = currentTask?.title
        descriptionTextField.text = currentTask?.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleTextField)
        titleTextField.text = "New Task"
        view.addSubview(descriptionTextField)
        descriptionTextField.text = "Description"
        view.backgroundColor = .white
        view.addSubview(okButton)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            descriptionTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            descriptionTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            okButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            okButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 65),
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65)
        ])
    }
}
