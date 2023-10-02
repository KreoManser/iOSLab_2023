//
//  TaskTableViewCell.swift
//  4HW
//
//  Created by Ruslan on 01.10.2023.
//

import UIKit


class TaskTableViewCell: UITableViewCell {

    
    
    private lazy var title: UITextView = {
        let title = UITextView()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 15)
        title.isEditable = false
        return title
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.backgroundColor = .systemOrange
        description.layer.cornerRadius = 10
        description.clipsToBounds = true
        description.font = UIFont.systemFont(ofSize: 12)
        description.isEditable = false
        return description
    }()
    
    private lazy var status: UITextView = {
        let status = UITextView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 9)
        status.isEditable = false
        return status
    }()
    
    private lazy var dateOfCreation: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .dateAndTime
        date.tintColor = .systemOrange
        date.inputViewController?.isEditing = false
        date.isUserInteractionEnabled = false
        return date
    }()
    
    private lazy var completionDate: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .dateAndTime
        date.tintColor = .systemOrange
        date.isUserInteractionEnabled = false
        return date
    }()
    
    private lazy var createDataLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Старт: "
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var completDataLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Конец: "
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayuotCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
    }
    
    func configureCell(with task: Task) {
        title.text = task.title
        descriptionLabel.text = task.description
        status.text = task.status
        dateOfCreation.date = task.dateOfCreation
        completionDate.date = task.completionDate
    }
    
    func setupLayuotCell() {
        guard title.superview == nil else { return }
        contentView.addSubview(title)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(status)
        contentView.addSubview(dateOfCreation)
        contentView.addSubview(completionDate)
        contentView.addSubview(completDataLabel)
        contentView.addSubview(createDataLabel)
        NSLayoutConstraint.activate([
            
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 100),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            
            status.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            status.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            status.widthAnchor.constraint(equalToConstant: 85),
            status.heightAnchor.constraint(equalToConstant: 30),
            
            createDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            createDataLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            
            dateOfCreation.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            dateOfCreation.leadingAnchor.constraint(equalTo: createDataLabel.trailingAnchor, constant: 10),
            
            completDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            completDataLabel.topAnchor.constraint(equalTo: createDataLabel.bottomAnchor, constant: 25),
            
            completionDate.topAnchor.constraint(equalTo: dateOfCreation.bottomAnchor, constant: 10),
            completionDate.leadingAnchor.constraint(equalTo: completDataLabel.trailingAnchor, constant: 10),

        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
        
    }
}
