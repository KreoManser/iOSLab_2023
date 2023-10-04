//
//  DetailViewController.swift
//  MyToDo
//
//  Created by Rustem on 04.10.2023.
//

import UIKit

protocol DetailViewDelegate{
    func didPressSaveButton(task: MyTask)
}

class DetailViewController: UIViewController{
    
    var currentTask: MyTask!
    init(with task: MyTask, delegate: DetailViewDelegate){
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.currentTask = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textField: UITextField = {
        var label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionTextField: UITextField = {
        var text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = currentTask.description
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .white
        return text
    }()
    
    var delegate: DetailViewDelegate?
    
    private lazy var saveButton: UIButton = {
        
        let action = UIAction { _ in
            self.currentTask.title = self.textField.text ?? ""
            self.currentTask.description = self.descriptionTextField.text ?? ""
            self.delegate?.didPressSaveButton(task: self.currentTask)
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Сохранить", for: .normal)
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupViews()
        SetupLayout()
        
    }
    
    private func SetupLayout(){
        navigationController?.navigationBar.tintColor = .orange
        textField.text = currentTask?.title
        self.view.backgroundColor = .black
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
            descriptionTextField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            descriptionTextField.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    private func SetupViews(){
        self.view.addSubview(textField)
        self.view.addSubview(descriptionTextField)
        self.view.addSubview(saveButton)
    }
}
