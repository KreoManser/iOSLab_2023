//
//  FriendsView.swift
//  CatGram
//
//  Created by Mac on 2023-11-26.
//

import UIKit

class FriendsView: UIView {
    lazy var friendsTableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayouts() {
        addSubview(friendsTableView)
        friendsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            friendsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            friendsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            friendsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
