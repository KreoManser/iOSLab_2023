//
//  contentsOfEachDayTableViewCell.swift
//  homeWork4
//
//  Created by marwa awwad mohamed awwad on 01.10.2023.
//

import UIKit


class contentsOfEachDayTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightSideLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with TODO: Time) {
        
        avatarImageView.image = TODO.avater
        titleLabel.text = TODO.time
        subtitleLabel.text = TODO.description
        rightSideLabel.text = TODO.done
    }
    
    private func setupLayout() {
        
        guard avatarImageView.superview == nil else { return }
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(rightSideLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 10),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rightSideLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            rightSideLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 150)
            
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}



