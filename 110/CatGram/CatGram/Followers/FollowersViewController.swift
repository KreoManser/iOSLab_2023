//
//  FollowersViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.11.2023.
//

import UIKit

class FollowersViewController: UIViewController {

    private var followersView: FollowersView?
    private var followersDataManager: FollowersDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            self.navigationController?.tabBarController?.tabBar.isHidden = false
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = "Подписчики"
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setUpSettings() {
        followersView = FollowersView(frame: .zero)
        followersDataManager = FollowersDataManager()
        view = followersView
        followersView?.followersTableView.delegate = followersDataManager
        followersView?.followersTableView.dataSource = followersDataManager
        followersView?.followersTableView.register(FollowersCell.self, forCellReuseIdentifier: FollowersCell.reuseIdentifier)
    }

}
