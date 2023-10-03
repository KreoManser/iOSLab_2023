//
//  TableViewCell.swift
//  ToDoApp
//
//  Created by Faki Doosuur Doris on 30.09.2023.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didTapcell()
}

class TaskTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var descriptionLabel: UILabel = {
         let myText = UILabel()
         myText.translatesAutoresizingMaskIntoConstraints = false
         return myText
     }()
    lazy var priorityLabel: UILabel = {
         let myText = UILabel()
         myText.translatesAutoresizingMaskIntoConstraints = false
         return myText
     }()
    lazy var dateLabel: UILabel = {
         let myDate = UILabel()
        myDate.font = UIFont.systemFont(ofSize: 14)
         myDate.translatesAutoresizingMaskIntoConstraints = false
         return myDate
     }()
    
    weak var delegate: TaskCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        descriptionLabel.removeFromSuperview()
        self.isEditing = true
        
        setUpLayout()
    
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
       
               
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -120),
            dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
        ])
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
