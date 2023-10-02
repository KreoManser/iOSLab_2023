import UIKit
protocol TaskCellDelegate : AnyObject{
    func deleteCell(task: Task)
}

 class TaskTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
     private lazy var deleteButton: UIButton = {
         let button = UIButton()
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("X", for: .normal)
         button.backgroundColor = .red.withAlphaComponent(0.7)
         button.layer.cornerRadius = 8
         return button
     }()
     weak var delegate : TaskCellDelegate?
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(deleteButton)
        setupLayout()
        backgroundColor = .systemTeal.withAlphaComponent(0.9)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(with task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.shortDescription
        let action = UIAction{ _ in
            self.delegate?.deleteCell(task: task)
        }
        deleteButton.addAction(action, for: .touchUpInside)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
