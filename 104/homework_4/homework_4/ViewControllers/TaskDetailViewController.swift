import UIKit

internal class TaskDetailScreenViewController: UIViewController, UITextViewDelegate {
    private lazy var titleTextView: UITextView = {
        let title = UITextView();
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.font = UIFont.boldSystemFont(ofSize: 15);
        
        return title;
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let description = UITextView();
        description.translatesAutoresizingMaskIntoConstraints = false;
        description.backgroundColor = .systemIndigo;
        description.layer.cornerRadius = 10;
        description.delegate = self;
        description.clipsToBounds = true;
        description.font = UIFont.systemFont(ofSize: 12);
        
        return description;
    }()
    
    private lazy var statusTextView: UITextView = {
        let status = UITextView();
        status.translatesAutoresizingMaskIntoConstraints = false;
        status.font = UIFont.boldSystemFont(ofSize: 12);
        
        return status;
    }()
    
    private lazy var creationDatePicker: UIDatePicker = {
        let date = UIDatePicker();
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.datePickerMode = .dateAndTime;
        date.tintColor = .systemIndigo;
        
        return date;
    }()
    
    private lazy var completionDatePicker: UIDatePicker = {
        let date = UIDatePicker();
        date.translatesAutoresizingMaskIntoConstraints = false;
        date.datePickerMode = .dateAndTime;
        date.tintColor = .systemIndigo;
        
        return date;
    }()
    
    private lazy var creationDateLabel : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Старт: ";
        label.font = UIFont.systemFont(ofSize: 12);
        
        return label;
    }()
    
    private lazy var completionDateLabel : UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Конец: ";
        label.font = UIFont.systemFont(ofSize: 12);
        
        return label;
    }()

    
    private weak var delegate: DetailControllerDelegate?;
    private var currentTask: Task!;
    
    private lazy var button: UIButton = {
        let action = UIAction { _ in
            let updatedTitle = self.titleTextView.text ?? "";
            let updatedDescription = self.descriptionTextView.text ?? "";
            let updatedStatus = self.statusTextView.text ?? "";
            let updatedDateOfCreation = self.creationDatePicker.date;
            let updatedCompletionDate = self.completionDatePicker.date;

            let updateTask = Task(
                id: self.currentTask.id,
                title: updatedTitle,
                description: updatedDescription,
                status: updatedStatus,
                creationDate: updatedDateOfCreation,
                completionDate: updatedCompletionDate
            );
            
            self.delegate?.dataUpdate(for: updateTask);
            self.navigationController?.popViewController(animated: true);
        }
        
        let button = UIButton(configuration: .filled(), primaryAction: action);
        button.setTitle("Сохранить", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        
        return button;
    }()

    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
    }
 
    init(with task: Task, delegate: DetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil);
        
        self.currentTask = task;
        self.delegate = delegate;
        titleTextView.text = currentTask.title;
        statusTextView.text = currentTask.status;
        descriptionTextView.text = currentTask.description;
        completionDatePicker.date = currentTask.completionDate;
        creationDatePicker.date = currentTask.creationDate;
        
        addSubviews();
        setupConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        view.addSubview(titleTextView);
        view.addSubview(descriptionTextView);
        view.addSubview(statusTextView);
        view.addSubview(creationDatePicker);
        view.addSubview(completionDatePicker);
        view.addSubview(completionDateLabel);
        view.addSubview(creationDateLabel);
        view.addSubview(button);
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleTextView.widthAnchor.constraint(equalToConstant: 100),
            titleTextView.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 400),
            
            statusTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            statusTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            statusTextView.widthAnchor.constraint(equalToConstant: 85),
            statusTextView.heightAnchor.constraint(equalToConstant: 20),
            
            creationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            creationDateLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            
            creationDatePicker.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            creationDatePicker.leadingAnchor.constraint(equalTo: creationDateLabel.trailingAnchor, constant: 10),
            
            completionDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            completionDateLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 25),
            
            completionDatePicker.topAnchor.constraint(equalTo: creationDatePicker.bottomAnchor, constant: 10),
            completionDatePicker.leadingAnchor.constraint(equalTo: completionDateLabel.trailingAnchor, constant: 10),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]);
    }
}
