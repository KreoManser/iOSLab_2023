import UIKit

class TaskTableViewCell: UITableViewCell {
    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskDateOfAddLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taskPriorityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskNameLabel.text = nil
        taskDescriptionLabel.text = nil
        taskDateOfAddLabel.text = nil
        taskPriorityLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(task: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        taskPriorityLabel.text = task.priority.rawValue
        taskNameLabel.text = task.name
        taskDescriptionLabel.text = task.description
        taskDateOfAddLabel.text = dateFormatter.string(from: task.dateOfAdd)
    }
    
    func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(taskPriorityLabel)
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskDateOfAddLabel)
        contentView.addSubview(taskDescriptionLabel)
        
        NSLayoutConstraint.activate([
            taskPriorityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskPriorityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            taskDateOfAddLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            taskDateOfAddLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            taskDescriptionLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: taskDateOfAddLabel.trailingAnchor, constant: 15),
            taskDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
