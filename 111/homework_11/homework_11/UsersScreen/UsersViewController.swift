//
//  UsersViewController.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 17.12.2023.
//

import UIKit

class UsersViewController: UIViewController {

    private var usersView: UsersView?
    private var usersDataManager: UsersDataManager?
    private var coreDataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        usersDataManager = UsersDataManager()
        setUpFriendsView()
        setUpNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersDataManager?.updateTableWithCachedData()
        usersView?.usersTableView.reloadData()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Все пользователи"
    }

    private func setUpFriendsView() {
        usersView = UsersView(frame: view.bounds)
        usersView?.usersTableView.delegate = usersDataManager
        usersView?.usersTableView.dataSource = usersDataManager
        usersView?.usersTableView.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.reuseIdentifier)
        view = usersView
    }

}
