//
//  TaskDetailViewController.swift
//  104
//
//  Created by Dmitry on 02.10.2023.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    lazy var nameTaskTextView: UITextView = {
        let nameTextView = UITextView()
        nameTextView.font = UIFont.systemFont(ofSize: 30)
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        nameTextView.textAlignment = .left
        nameTextView.tintColor = .gray
        
        return nameTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameTaskTextView)
        setUpConstraints()
        view.backgroundColor = .white
    }
    
    func configureViewController(with: Task) {
        nameTaskTextView.text = with.name
    }
}

extension TaskDetailViewController {
    func setUpConstraints() {
        setUpNameTaskLabelConstraints()
    }
    
    func setUpNameTaskLabelConstraints() {
        NSLayoutConstraint.activate([
            nameTaskTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameTaskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTaskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTaskTextView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
