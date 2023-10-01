//
//  TaskTableCell.swift
//  104
//
//  Created by Dmitry on 01.10.2023.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didPressedTaskEditButton()
}

class TaskTableCell: UITableViewCell {
    
    weak var delegate: TaskCellDelegate?
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Задача"
        return label
    }()
    
    lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Описание"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskDescriptionLabel)
        }

}

extension TaskTableCell {
    func setUpConstraints() {
        setUpTaskNameLabelConstraints()
        setUpTaskDescriptionConstraints()
        }
    
    func setUpTaskNameLabelConstraints() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
    
    func setUpTaskDescriptionConstraints() {
        NSLayoutConstraint.activate([
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
    
    func configureCell(with: Task) {
        taskNameLabel.text = with.name
        taskDescriptionLabel.text = with.description
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


