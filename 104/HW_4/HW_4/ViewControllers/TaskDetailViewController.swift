import UIKit

protocol TaskDetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class TaskDetailViewController: UIViewController {
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 30, weight: .bold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var editButtom: UIButton = {
        let action = UIAction { _ in
            let updatedTask = Task(id: self.currentTask.id, name: self.nameTextField.text ?? "", description: self.descriptionTextView.text ?? "", dateOfAdd: Date())
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
}
