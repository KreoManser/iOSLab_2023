//
//  TaskTableViewCell.swift
//  HW4_ToDoList
//
//  Created by Артур Миннушин on 02.10.2023.
//

import UIKit

protocol UserCellDelegate: AnyObject {
    func didPressDetailDisclosure()
}

class TaskTableViewCell: UITableViewCell {

    weak var delegate: UserCellDelegate?
    
    private lazy var taskName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionTask: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with task: Task) {
        
        taskName.text = task.nameTask
        descriptionTask.text = task.descriptionTask
    }
    
    private func setupLayout() {
        let mainStackView = UIStackView(arrangedSubviews: [taskName, descriptionTask])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }

    
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
