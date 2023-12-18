//
//  UsersView.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 17.12.2023.
//

import UIKit

class UsersView: UIView {
    lazy var usersTableView: UITableView = UITableView()

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
        addSubview(usersTableView)
        usersTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            usersTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
