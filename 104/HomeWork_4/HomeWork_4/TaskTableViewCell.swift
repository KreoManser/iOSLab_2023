//
//  TaskTableViewCell.swift
//  HomeWork_4
//
//  Created by Нияз Ризванов on 02.10.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
    }
    
    func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
        ])
    }
    
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
