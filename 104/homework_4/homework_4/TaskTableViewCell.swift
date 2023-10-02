//
//  TaskTableTableViewCell.swift
//  homework_4
//
//  Created by Кирилл Щёлоков on 02.10.2023.
//

import UIKit

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func didDeleteTask(task: Task)
}

class TaskTableViewCell: UITableViewCell {
        
    //MARK: Variables
    
    weak var delegate: TableViewCellDelegate?

    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    lazy var completionImageView : UIImageView = {
        let completionImageView = UIImageView()
        return completionImageView
    }()
    
    lazy var deleteButton : UIButton = {
        let deleteButton = UIButton()
        return deleteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(completionImageView)
        contentView.addSubview(deleteButton)
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        ])
        
        if task.completionDate != nil {
            completionImageView.image = UIImage(named: "checkedImage")
        } else {
            completionImageView.image = UIImage(named: "progressImage")
        }
        completionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            completionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completionImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -55),
            completionImageView.heightAnchor.constraint(equalToConstant: 40),
            completionImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        deleteButton.setImage(UIImage(named: "deleteImage"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        let deleteAction = UIAction { _ in
            self.delegate?.didDeleteTask(task: task)
        }
        
        deleteButton.addAction(deleteAction, for: .touchUpInside)
    }
}

extension UITableViewCell{
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}
