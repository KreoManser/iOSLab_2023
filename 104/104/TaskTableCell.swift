//
//  TaskTableCell.swift
//  104
//
//  Created by Dmitry on 01.10.2023.
//

import UIKit


protocol TaskCellDelegate: AnyObject {
    func taskIsDone(task: Task)
}

class TaskTableCell: UITableViewCell {
    
    private weak var delegate: TaskListViewController?
    
    private var task: Task!
    
    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var doneTaskButton: UIButton = {
        let action = UIAction { _ in
            self.delegate?.taskIsDone(task: self.task)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 2)
        button.setTitle("Ок", for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskTableCell {
    private func setUpConstraints() {
        setUpTaskNameLabelConstraints()
        setUpTaskDescriptionConstraints()
        setUpDoneTaskButtonConstraints()
        }
    
    private func setUpTaskNameLabelConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskNameLabel.trailingAnchor.constraint(equalTo: doneTaskButton.leadingAnchor, constant: -10),
        ])
    }
    
    private func setUpTaskDescriptionConstraints() {
        NSLayoutConstraint.activate([
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskDescriptionLabel.trailingAnchor.constraint(equalTo: doneTaskButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func setUpDoneTaskButtonConstraints() {
        NSLayoutConstraint.activate([
            doneTaskButton.widthAnchor.constraint(equalToConstant: 50),
            doneTaskButton.heightAnchor.constraint(equalToConstant: 20),
            doneTaskButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            doneTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setUpLayout() {
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskDescriptionLabel)
        contentView.addSubview(doneTaskButton)
        }
    
    internal func configureCell(with: Task, delegate: TaskListViewController?) {
        taskNameLabel.text = with.name
        taskDescriptionLabel.text = with.description
        task = with
        self.delegate = delegate
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


