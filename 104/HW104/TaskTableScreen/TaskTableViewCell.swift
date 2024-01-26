//
//  UserTableViewCell.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 21.01.2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    let avatarImageViewHeightWidthAnchorConstraint = 25
    let mainStackViewRightLeadingAnchorConstraint = 16
    let flagConstraintsWidthHeight = 24
    
    var task: Task?
    
    private lazy var buttonTaskIsCompleted: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var flagImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        buttonTaskIsCompleted.setImage(UIImage(named: "checkbox_notSelected"), for: .normal)
        buttonTaskIsCompleted.setImage(UIImage(named: "checkbox_selected"), for: .selected)
        buttonTaskIsCompleted.addTarget(self, action: #selector(buttonTaskIsCompletedTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buttonTaskIsCompleted.setImage(UIImage(), for: .normal)
    }
    
    func configureCell(with task: Task) {
        self.task = task
        buttonTaskIsCompleted.setImage(UIImage(named: "checkbox_notSelected"), for: .normal)
        nameLabel.text = task.title
        buttonTaskIsCompleted.isSelected = task.isTaskDone
        
        switch task.priority {
        case .high:
            flagImageView.image = UIImage(named: "red_flag")
            break
        case .middle:
            flagImageView.image = UIImage(named: "orange_flag")
            break
        case .low:
            flagImageView.image = UIImage(named: "yellow_flag")
            break
        default:
            flagImageView.image = UIImage(named: "gray_flag")
            break
        }
    }
    
    private func setupLayout() {
        guard buttonTaskIsCompleted.superview == nil else { return}
        let mainStackView = UIStackView(arrangedSubviews: [nameLabel])
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(buttonTaskIsCompleted)
        contentView.addSubview(mainStackView)
        contentView.addSubview(flagImageView)
        
        
        NSLayoutConstraint.activate([
            buttonTaskIsCompleted.widthAnchor.constraint(equalToConstant: CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            buttonTaskIsCompleted.heightAnchor.constraint(equalToConstant: CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            buttonTaskIsCompleted.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonTaskIsCompleted.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(mainStackViewRightLeadingAnchorConstraint)),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: buttonTaskIsCompleted.trailingAnchor, constant: CGFloat(mainStackViewRightLeadingAnchorConstraint)),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            flagImageView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(avatarImageViewHeightWidthAnchorConstraint)),
            flagImageView.widthAnchor.constraint(equalToConstant: CGFloat(flagConstraintsWidthHeight)),
            flagImageView.heightAnchor.constraint(equalToConstant: CGFloat(flagConstraintsWidthHeight))
        ])
    }
    
    @objc func buttonTaskIsCompletedTapped() {
        buttonTaskIsCompleted.isSelected.toggle()
        task?.isTaskDone = buttonTaskIsCompleted.isSelected
        nameLabel.textColor = task?.isTaskDone == true ? UIColor.lightGray : UIColor.black
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
