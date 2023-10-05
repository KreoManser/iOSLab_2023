//
//  EditDetailViewController.swift
//  HW4
//
//  Created by Kseniya Skvortsova on 05.10.2023.
//

import UIKit

protocol EditDetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class EditDetailViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text="Task name:"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text="About task:"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startingDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text="From date:"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endingDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text="To date:"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text="Task type:"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subtitleTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startingDateTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var endingDateTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var typeTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private weak var delegate: EditDetailControllerDelegate?
    private var currentTask: Task!
    
    init(with task: Task, delegate: EditDetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentTask = task
        self.delegate = delegate
        
        titleTextField.text=currentTask.name
        subtitleTextField.text=currentTask.subtitle
        startingDateTextField.text = currentTask.startingDate
        endingDateTextField.text=currentTask.endingDate
        typeTextField.text=currentTask.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupLayout()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let saveAction = UIAction { _ in
            let updatedTask = Task(id: self.currentTask.id,
                                   name: self.titleTextField.text ?? "New task",
                                   subtitle: self.subtitleTextField.text ?? "New task",
                                   startingDate: self.startingDateTextField.text ?? "-",
                                   endingDate: self.endingDateTextField.text ?? "-",
                                   type: self.typeTextField.text ?? "Task")
            
                        self.delegate?.dataUpdated(for: updatedTask)
                        self.navigationController?.popViewController(animated: true)
        }
        
        navigationItem.title = "Edit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: saveAction, menu: nil)
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    func setupLayout() {
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, titleTextField, startingDateLabel, startingDateTextField, endingDateLabel, endingDateTextField, typeLabel, typeTextField, subtitleLabel, subtitleTextField])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing=5
        mainStackView.setCustomSpacing(20, after: titleTextField)
        mainStackView.setCustomSpacing(20, after: endingDateTextField)
        mainStackView.setCustomSpacing(20, after: typeTextField)
        
        addSubviews(mainStackView)
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}
