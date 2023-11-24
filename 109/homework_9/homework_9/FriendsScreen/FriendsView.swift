//
//  FriendsView.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import UIKit

class FriendsView: UIView {
    lazy var friendsTableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpFriendsTableView()
    }

    private func setUpFriendsTableView() {
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
