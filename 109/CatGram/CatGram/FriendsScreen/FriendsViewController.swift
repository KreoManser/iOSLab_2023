//
//  FriendsViewController.swift
//  CatGram
//
//  Created by Mac on 2023-11-26.
//

import UIKit

class FriendsViewController: UIViewController {
    private let friendsView = FriendsView(frame: .zero)
    private let friendsDataManager = FriendsDataSourse()

    override func viewDidLoad() {
        super.viewDidLoad()
        friendsView.friendsTableView.delegate = friendsDataManager
        friendsView.friendsTableView.dataSource = friendsDataManager
        friendsView.friendsTableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.reuseIdentifier)
        view = friendsView
    }

}
