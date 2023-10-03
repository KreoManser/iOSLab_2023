import UIKit

protocol NewTaskControllerDelegate: AnyObject {
    func addTask(for task: Task)
}

class NewTaskViewController: UIViewController {
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 30, weight: .bold)
        textField.attributedPlaceholder = .init(string: "Task name")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var editButtom: UIButton = {
        let action = UIAction { _ in
            let newTask = Task(id: UUID(), name: self.nameTextField.text ?? "", description: self.descriptionTextView.text ?? "", dateOfAdd: Date())
            self.delegate?.addTask(for: newTask)
            self.navigationController?.popViewController(animated: true)
        }
        
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: NewTaskControllerDelegate?
    
    init(delegate: NewTaskControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.delegate = delegate
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
