//
//  profile.swift
//  homeWork3
//
//  Created by marwa awwad mohamed awwad on 10.10.2023.
//

import Foundation
import UIKit

class page: UIViewController {
    private lazy var loggedIn: UILabel = {
        let view = UILabel()
        view.text = "you logged in to your account "
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(loggedIn)
        configuration()
    }
    private func configuration() {
        
        
        NSLayoutConstraint.activate([
            loggedIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loggedIn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        ])
        
    }
}
