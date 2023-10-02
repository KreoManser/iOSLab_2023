//
//  TaskTableViewCell.swift
//  HW_104
//
//  Created by Азат Зиганшин on 02.10.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var taskDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    func configureCell(with task: Task) {
        title.text = task.title
        taskDescription.text = task.description
    }

    private func setupLayout() {
        contentView.addSubview(title)
        contentView.addSubview(taskDescription)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            taskDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            taskDescription.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            taskDescription.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            taskDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
