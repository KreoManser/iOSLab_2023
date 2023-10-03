import UIKit

internal class TaskTableViewCell: UITableViewCell {
    private lazy var title: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold);
        
        return label;
    }()
    
    private lazy var contentContainer: UIView = {
        let view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = .systemIndigo;
        view.layer.cornerRadius = 10;
        
        return view;
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 14);
        label.numberOfLines = 0;
        
        return label;
    }()
    
    private lazy var status: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.boldSystemFont(ofSize: 12);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var dateOfCreation: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 12);
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var completionDate: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 12);
        label.textColor = .black;
        
        return label;
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        addSubviews();
        setupConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        title.text = nil;
        descriptionLabel.text = nil;
        status.text = nil;
        dateOfCreation.text = nil;
        completionDate.text = nil;
    }
    
    func configureCell(with task: Task) {
        title.text = task.title;
        descriptionLabel.text = task.description;
        status.text = task.status;
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm";
        dateOfCreation.text = "Старт: \(dateFormatter.string(from: task.creationDate))";
        completionDate.text = "Конец: \(dateFormatter.string(from: task.completionDate))";
    }
    
    private func addSubviews() {
        contentView.addSubview(contentContainer);
        contentContainer.addSubview(title);
        contentContainer.addSubview(descriptionLabel);
        contentContainer.addSubview(status);
        contentContainer.addSubview(dateOfCreation);
        contentContainer.addSubview(completionDate);
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            title.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -10),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -10),
            
            status.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            status.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -10),
            dateOfCreation.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            dateOfCreation.bottomAnchor.constraint(equalTo: status.topAnchor, constant: -5),
            
            completionDate.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            completionDate.bottomAnchor.constraint(equalTo: dateOfCreation.topAnchor, constant: -5)
        ]);
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self);
    }
}
