import UIKit

protocol TaskDetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class TaskDetailViewController: UIViewController {
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 30, weight: .bold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var editButtom: UIButton = {
        let action = UIAction { _ in
            var updatedTask = Task(name: self.nameTextField.text ?? "", description: self.descriptionTextView.text ?? "", dateOfAdd: Date(), priority: self.currentTask.priority)
            updatedTask.id = self.currentTask.id
            self.delegate?.dataUpdated(for: updatedTask)
            self.navigationController?.popViewController(animated: true)
        }
        
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: TaskDetailControllerDelegate?
    private var currentTask: Task!
    
    init(with task: Task, delegate: TaskDetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.currentTask = task
        self.delegate = delegate
        
        descriptionTextView.text = currentTask.description
        nameTextField.text = currentTask.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(editButtom)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            descriptionTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            editButtom.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            editButtom.widthAnchor.constraint(equalToConstant: 70),
            editButtom.heightAnchor.constraint(equalToConstant: 35),
            editButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupMenu() -> UIMenu {
        let lowPriority = UIAction(title: "Low") { _ in
            self.currentTask.priority = .low
            self.setupNavigationBar()
        }
        let mediumPriority = UIAction(title: "Medium") { _ in
            self.currentTask.priority = .medium
            self.setupNavigationBar()
        }
        let highPriority = UIAction(title: "High") { _ in
            self.currentTask.priority = .high
            self.setupNavigationBar()
        }
        
        switch currentTask.priority {
        case .low:
            lowPriority.state = .on
        case .medium:
            mediumPriority.state = .on
        case .high:
            highPriority.state = .on
        }
        
        return UIMenu(title: "Priority", children: [lowPriority, mediumPriority, highPriority])
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: setupMenu())
    }
}
