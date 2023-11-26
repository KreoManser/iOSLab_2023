//
//  FollowersView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import UIKit

class FollowersView: UIView, UITableViewDelegate {

    lazy var followersTableView: UITableView = {
        let followersTableView = UITableView()
        followersTableView.separatorStyle = .none
        followersTableView.translatesAutoresizingMaskIntoConstraints = false
        return followersTableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTableView()
        backgroundColor = .white

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTableView() {
        addSubview(followersTableView)
        NSLayoutConstraint.activate([
            followersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            followersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            followersTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            followersTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
