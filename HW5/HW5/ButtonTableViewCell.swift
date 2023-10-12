//
//  ButtonTableViewCell.swift
//  HW5
//
//  Created by Kseniya Skvortsova on 12.10.2023.
//

import UIKit

protocol ButtonCellDelegate: AnyObject {
    func buttonTapped(for button: String)
}

class ButtonTableViewCell: UITableViewCell {
    
    private var currentButton: Button!
    
    private lazy var button1: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.baseForegroundColor = .white
       
        let action = UIAction { _ in
            self.delegate?.buttonTapped(for: self.currentButton.type[0])
        }
        let button = UIButton(configuration: config, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var button2: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.baseForegroundColor = .white
       
        let action = UIAction { _ in
            self.delegate?.buttonTapped(for: self.currentButton.type[1])
        }
        let button = UIButton(configuration: config, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var button3: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        config.baseForegroundColor = .white
       
        let action = UIAction { _ in
            self.delegate?.buttonTapped(for: self.currentButton.type[2])
        }
        let button = UIButton(configuration: config, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var button4: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .orange
        config.baseForegroundColor = .white
       
        let action = UIAction { _ in
            self.delegate?.buttonTapped(for: self.currentButton.type[3])
        }
        let button = UIButton(configuration: config, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: ButtonCellDelegate?
    
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
    
    func configureCell(with button: Button) {
        
        currentButton=button
        
        if !button.color{
            button1.configuration?.baseBackgroundColor = .darkGray
            button2.configuration?.baseBackgroundColor = .darkGray
            button3.configuration?.baseBackgroundColor = .darkGray
        }
        
        button1.configuration?.title=button.type[0]
        button2.configuration?.title=button.type[1]
        button3.configuration?.title=button.type[2]
        button4.configuration?.title=button.type[3]
    }
    
    private func setupLayout() {
        
        let mainStackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        mainStackView.axis = .horizontal
        mainStackView.spacing=5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let value=(UIScreen.main.bounds.width-25)/4
        
        button1.layer.cornerRadius = value/2
        button1.clipsToBounds = true
        button2.layer.cornerRadius = value/2
        button2.clipsToBounds = true
        button3.layer.cornerRadius = value/2
        button3.clipsToBounds = true
        button4.layer.cornerRadius = value/2
        button4.clipsToBounds = true
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            button1.widthAnchor.constraint(equalToConstant: value),
            button1.heightAnchor
                .constraint(equalTo: button1.widthAnchor, multiplier: 1),
            button2.widthAnchor.constraint(equalToConstant: value),
            button2.heightAnchor
                .constraint(equalTo: button2.widthAnchor, multiplier: 1),
            button2.widthAnchor.constraint(equalToConstant: value),
            button2.heightAnchor
                .constraint(equalTo: button3.widthAnchor, multiplier: 1),
            button2.widthAnchor.constraint(equalToConstant: value),
            button2.heightAnchor
                .constraint(equalTo: button4.widthAnchor, multiplier: 1),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
