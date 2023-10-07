//
//  TaskTableViewCell.swift
//  Homework4
//
//  Created by kerik on 01.10.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    private let dateFormatter = DateFormatter()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            contentView.backgroundColor = .white
            addSubviews(descriptionLabel
                        ,titleLabel, priorityLabel, dateLabel)
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureCell(with task: Task) {
            //isCompletedImage.image = UIImage(named: task.IsCompletedImageName)
            descriptionLabel.text = task.description
            titleLabel.text = task.title
            dateLabel.text = self.dateFormatter.string(from: task.creationDate)
            priorityLabel.text = "Приоритет: \(task.priority)"
        }
}

extension TaskTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            priorityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priorityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
