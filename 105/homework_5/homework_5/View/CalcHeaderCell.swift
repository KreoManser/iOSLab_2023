//
//  CalcHeaderCell.swift
//  homework_5
//
//  Created by marwa awwad mohamed awwad on 07.10.2023.
//

import UIKit

class CalcHeaderCell: UICollectionReusableView {
        
    static let identifer = "CalcHeaderCell"
    
    
    //MARK: - UIcomponent
    private var label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72,weight: .regular)
        label.text =  "Error"
        return label
        
    }()
    
    //MARK: - lifeCycle
    override init (frame:CGRect){
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(currentCalcText: String) {
        // Call the setupUI closure with 'self' as the UIView parameter
        setupUI()
        
        // Set the label text
        self.label.text = currentCalcText
    }

    //Mark: - UI setup
    private lazy var setupUI: () -> Void = { [self] in
        self.backgroundColor = .black
        self.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }

   
}
