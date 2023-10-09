//
//  OnePicrureTableViewCell.swift
//  HomeWork_3
//
//  Created by Нияз Ризванов on 25.09.2023.
//

import UIKit

class OnePicrureTableViewCell: UITableViewCell {
    
    private lazy var viewPicture: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        
        contentView.addSubview(viewPicture)
        
        setupLayuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayuot() {
        NSLayoutConstraint.activate([
            viewPicture.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            viewPicture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            viewPicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            viewPicture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
        ])
    }
}
