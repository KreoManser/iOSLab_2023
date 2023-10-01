//
//  TaskTableViewCell.swift
//  Homework4
//
//  Created by kerik on 01.10.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    private lazy var isCompletedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateFormatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            dateFormatter.dateFormat = "MM-dd-yyyy"
            contentView.backgroundColor = .white
            addSubviews(titleLabel, priorityLabel, dateLabel)
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureCell(with task: Task) {
            isCompletedImage.image = UIImage(named: task.IsCompletedImageName)
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
            isCompletedImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            isCompletedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            isCompletedImage.widthAnchor.constraint(equalToConstant: 25),
//            isCompletedImage.heightAnchor.constraint(equalToConstant: 25),
                        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: isCompletedImage.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                        
            priorityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            priorityLabel.leadingAnchor.constraint(equalTo: isCompletedImage.trailingAnchor, constant: 15),
            priorityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
