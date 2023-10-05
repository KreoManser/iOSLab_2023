//
//  TaskTableViewCell.swift
//  HW4
//
//  Created by Kseniya Skvortsova on 05.10.2023.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didPressDetailDisclosure(for task: Task)
}

class TaskTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var currentTask: Task!
    
    private lazy var showDeleteButton: UIButton = {
       
        let action = UIAction { _ in
            self.delegate?.didPressDetailDisclosure(for: self.currentTask)
        }
        let button = UIButton(type: .close, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: TaskCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with task: Task) {
        currentTask=task
        
        titleLabel.text = task.name
        subtitleLabel.text = task.subtitle
    }
    
    private func setupLayout() {
        
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = 5
        
        contentView.addSubview(mainStackView)
        contentView.addSubview(showDeleteButton)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            showDeleteButton.heightAnchor.constraint(equalToConstant: 20),
            showDeleteButton.widthAnchor.constraint(equalTo: showDeleteButton.heightAnchor, multiplier: 1),
            showDeleteButton.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            showDeleteButton.centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor),
            showDeleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

