//
//  TaskTableViewCell.swift
//  HW4
//
//  Created by Alina on 09.10.2023.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didPressDetailDisclosure()
}

class TaskTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let action = UIAction { _ in
            self.delegate?.didPressDetailDisclosure()
            self.doneButton.backgroundColor = .green
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .lightGray
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
        titleLabel.text = task.title
        descriptionLabel.text = task.description
    }
    
    private func setupLayout() {
        
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        

        contentView.addSubview(mainStackView)
        contentView.addSubview(doneButton)
        
        NSLayoutConstraint.activate([

            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            doneButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            doneButton.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 200),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
