//
//  UserTableViewCell.swift
//  MyToDo
//
//  Created by Rustem on 02.10.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var priorityImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .green
        return img
    }()
    
    private lazy var dateOfCreation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .orange
        return label
    }()
    
    private let dateFormatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dateFormatter.dateFormat = "dd.MM.yy"
        contentView.backgroundColor = .black
        addSubviews(subviews: taskTitle, priorityImg, dateOfCreation)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with task: MyTask) {
        
        taskTitle.text = task.title
        dateOfCreation.text = self.dateFormatter.string(from: task.creationDate)
        switch(task.priority){
        case 0: priorityImg.backgroundColor = .black
        case 1: priorityImg.backgroundColor = .green
        case 2: priorityImg.backgroundColor = .yellow
        case 3: priorityImg.backgroundColor = .red
        default: priorityImg.backgroundColor = .green
        }
    }
}

extension UserTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            taskTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            taskTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priorityImg.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 10),
            priorityImg.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor),
            priorityImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priorityImg.widthAnchor.constraint(equalToConstant: 10),
            priorityImg.heightAnchor.constraint(equalToConstant: 10),
            
            dateOfCreation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dateOfCreation.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
