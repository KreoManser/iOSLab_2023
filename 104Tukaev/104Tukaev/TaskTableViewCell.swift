//
//  TaskTableViewCell.swift
//  104Tukaev
//
//  Created by surexnx on 08.10.2023.
//

import UIKit
protocol DetailControllerDelegate: AnyObject {
    func dataUpdated(for task: Task)
}

class TaskTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    
    func ConfigureCell(with task: Task){
        avatarImageView.image = task.ProductImage
        nameLabel.text = task.name
        descriptionLabel.text = task.description
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskTableViewCell {
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach{contentView.addSubview($0)}
    }
    private func setupLayout(){
        guard avatarImageView.superview == nil else { return }
        
        addSubviews(avatarImageView, nameLabel, descriptionLabel)
        NSLayoutConstraint.activate([
            //я так и не понял почему Warning появляется тут
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

