//
//  detailTableViewCell.swift
//  homeWork4
//
//  Created by marwa awwad mohamed awwad on 02.10.2023.
//

import UIKit

protocol DetailControllerDelegate: AnyObject {
    func dataUpdated(for newNote: Time)
}
class detailTableViewCell: UIViewController {
    
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        
        return label
        
    }()
    
    init(with newNote : Time) {
        super.init(nibName: nil, bundle: nil)
        label.text = newNote.time
        label.text = newNote.description
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 3),

        ])
    }
}
