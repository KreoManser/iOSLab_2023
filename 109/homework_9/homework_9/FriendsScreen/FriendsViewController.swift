//
//  FriendsViewController.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import UIKit

class FriendsViewController: UIViewController {

    private var friendsView: FriendsView?
    private var friendsDataManager: FriendsDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        friendsDataManager = FriendsDataManager()
        setUpFriendsView()
        setUpNavigationBar()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Подписки"
    }

    private func setUpFriendsView() {
        friendsView = FriendsView(frame: view.bounds)
        friendsView?.friendsTableView.delegate = friendsDataManager
        friendsView?.friendsTableView.dataSource = friendsDataManager
        friendsView?.friendsTableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseIdentifier)
        view = friendsView
    }
}
