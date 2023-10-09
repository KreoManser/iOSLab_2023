//
//  TwoPictureTableViewCell.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 25.09.2023.
//

import UIKit

class TwoPictureTableViewCell: UITableViewCell {

    private lazy var leftPictureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var rightPictureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        
        contentView.addSubview(leftPictureView)
        contentView.addSubview(rightPictureView)
        
        setupLayuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayuot() {
        
        NSLayoutConstraint.activate([
            leftPictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leftPictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leftPictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            leftPictureView.widthAnchor.constraint(equalTo: rightPictureView.widthAnchor),

            rightPictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rightPictureView.leadingAnchor.constraint(equalTo: leftPictureView.trailingAnchor, constant: 10),
            rightPictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rightPictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
    }
}
