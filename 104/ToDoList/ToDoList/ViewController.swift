//
//  ViewController.swift
//  ToDoList
//
//  Created by Rustem on 02.10.2023.
//

import UIKit

class ViewController: UIViewController {
    private let contactButton: UIButton = {
       let button = UIButton()
        button.setTitle("Do smth", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupViews()
        setConstraints()
    }
    
    @objc func addTapped(){
        print("Создать задачу")
    }
    
    private func setupViews (){
        title = "CustomNavBar"
        view.addSubview(contactButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contactButton.heightAnchor.constraint(equalToConstant: 50),
            contactButton.widthAnchor.constraint(equalToConstant: 150)
            
        ])
    }
}

