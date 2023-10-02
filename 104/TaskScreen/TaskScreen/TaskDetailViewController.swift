import UIKit

class TaskDetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate: TaskDetailDelegate?
    var currentTask: Task!
    
    lazy var titleTextField: UITextField = {
        let text = UITextField ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.textColor = .black
        text.font = .systemFont(ofSize: 30, weight: .bold)
        return text

    }()
    lazy var descriptionTextView: UITextView = {
        let text = UITextView ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.isScrollEnabled = false
        return text
    }()
    
    lazy var okButton: UIButton = {
        let action = UIAction { _ in
            let updatedTask = Task(id: self.currentTask.id, title: self.titleTextField.text ?? "" , description: self.descriptionTextView.text ?? "")
            self.delegate?.saveData(task: updatedTask)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(task: Task, delegate: TaskDetailDelegate?) {
        super.init(nibName: nil, bundle: nil)

        self.currentTask = task
        self.delegate = delegate
        
        titleTextField.text = currentTask?.title
        descriptionTextView.text = currentTask?.description
            }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(okButton)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),

            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.topAnchor,constant: 40),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            
            okButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 100.0),
            okButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }

}
