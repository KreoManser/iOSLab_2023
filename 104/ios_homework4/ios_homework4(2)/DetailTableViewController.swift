
import UIKit

protocol DetailTableViewControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class DetailTableViewController: UITableViewController {
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private weak var delegate: DetailTableViewControllerDelegate?
    private var currentTask: Task!
    var snapshot = NSDiffableDataSourceSnapshot<TableSection, Task>()

    private var noteTextView: UITextView!

    init(with task: Task, delegate: DetailTableViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentTask = task
        self.delegate = delegate
        
        nameTextField.text = currentTask.name
        descriptionTextField.text = currentTask.description

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupNavigationBar()
        self.delegate?.dataUpdated(for: currentTask)
    }

    enum TableSection {
        case main
    }

    var dataSource: UITableViewDiffableDataSource<TableSection, Task>?

    func saveTask() {
        let updatedTask = Task(id: self.currentTask.id,
                               name: nameTextField.text!,
                               description: descriptionTextField.text ?? "nothing")
        
        self.delegate?.dataUpdated(for: updatedTask)
        self.navigationController?.popViewController(animated: true)
    }

    func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.configureCell(with: task)
            return cell
        })
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Change Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: UIAction(handler: { (_) in
            self.saveTask()
        }), menu: nil)
    }

    private func setupLayout() {
        
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        
        setupNavigationBar()
        setUpDataSource()
        
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            descriptionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }

}
