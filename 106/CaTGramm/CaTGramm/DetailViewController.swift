//
//  DetailViewController.swift
//  CaTGramm
//
//  Created by Rustem on 30.10.2023.
//

import UIKit

class DetailViewController: UIViewController {

    let navLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.backgroundColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "мой ник\nпубликации"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navLabel
        view.backgroundColor = .white
    }
}
