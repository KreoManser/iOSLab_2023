//
//  TaskTableViewCell.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 29.09.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - UI elements
    private lazy var isCompletedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let dateFormatter = DateFormatter()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        contentView.backgroundColor = .white
        addSubviews(subviews: isCompletedImage, taskNameLabel, priorityLabel, creationDateLabel)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with task: ToDoTask) {
        isCompletedImage.image = UIImage(named: task.IsCompletedImageName)
        taskNameLabel.text = task.name
        creationDateLabel.text = self.dateFormatter.string(from: task.creationDate)
        priorityLabel.text = "Приоритет: \(task.priority)"
    }
}

// MARK: - extension TaskTableViewCell
extension TaskTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            isCompletedImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            isCompletedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            isCompletedImage.widthAnchor.constraint(equalToConstant: 25),
            isCompletedImage.heightAnchor.constraint(equalToConstant: 25),
            
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            taskNameLabel.leadingAnchor.constraint(equalTo: isCompletedImage.trailingAnchor, constant: 15),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priorityLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 20),
            priorityLabel.leadingAnchor.constraint(equalTo: isCompletedImage.trailingAnchor, constant: 15),
            priorityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            creationDateLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 20),
            creationDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            creationDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
