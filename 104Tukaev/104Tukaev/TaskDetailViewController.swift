import UIKit

protocol TaskDetailControllerDelegate: AnyObject{
    func dateUpdated(for task: Task)
}

class TaskDetailViewController: UIViewController {
    
    private lazy var nameTexTField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var descriptionTexTField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var backButton: UIButton = {
        
        let action = UIAction { _ in
            let updateTask = Task(id: self.currentTask.id, name: self.nameTexTField.text!, description: self.descriptionTexTField.text! , ProductImage: self.currentTask.ProductImage )
            self.delegate?.dateUpdated(for: updateTask)
            self.navigationController?.popViewController(animated: false)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        
        let action = UIAction { _ in
            let updateTask = Task(id: self.currentTask.id, name: "$delete$", description: "", ProductImage: nil)
            self.delegate?.dateUpdated(for: updateTask)
            self.navigationController?.popViewController(animated: false)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        return button
    }()
    
    private var currentTask: Task!
    private weak var delegate: TaskDetailControllerDelegate?
    
    init(with task: Task, delegate: TaskDetailControllerDelegate){
        super.init(nibName: nil, bundle: nil)
        
        nameTexTField.text = task.name
        descriptionTexTField.text = task.description
        self.currentTask = task
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews(nameTexTField, descriptionTexTField, backButton, deleteButton)
        setupLayout()
    }
    
}
extension TaskDetailViewController{
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0) }
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            nameTexTField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameTexTField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTexTField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            descriptionTexTField.topAnchor.constraint(equalTo: nameTexTField.bottomAnchor, constant: 10),
            descriptionTexTField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionTexTField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            backButton.topAnchor.constraint(equalTo: descriptionTexTField.bottomAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: descriptionTexTField.leadingAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            deleteButton.topAnchor.constraint(equalTo: descriptionTexTField.bottomAnchor, constant: 10),
            deleteButton.widthAnchor.constraint(equalToConstant: 100),
            deleteButton.trailingAnchor.constraint(equalTo: descriptionTexTField.trailingAnchor)
            
        ])
    }
}
