//
//  FriendsViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class FriendsViewController: UIViewController {
    var friendsView: FriendsView?
    var friendsDataManager: FriendDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        friendsDataManager = FriendDataManager.shared
        setUpView()
 }

    private func setUpView() {
        friendsView = FriendsView(frame: view.bounds)
        friendsView?.tableView.delegate = friendsDataManager
        friendsView?.tableView.dataSource = friendsDataManager
        friendsView?.tableView.register(FriendsTableViewCell.self,
                                        forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifierforTableView)
        view = friendsView
    }

}
