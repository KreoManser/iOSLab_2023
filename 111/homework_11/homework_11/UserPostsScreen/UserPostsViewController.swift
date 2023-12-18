//
//  UserPostsViewController.swift
//  homework_11
//
//  Created by Кирилл Щёлоков on 18.12.2023.
//

import UIKit

class UserPostsViewController: UIViewController {

    private var userPostsView: UserPostsView?
    private var userPostsManager: UserPostsDataManager?
    private var indexPath: IndexPath

    init(indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        userPostsManager = UserPostsDataManager()
        setUpNavigationBar()
        setupPostView()
        userPostsManager?.optionsTapped = { [weak self] alertController in
            self?.present(alertController, animated: true, completion: nil)
        }
        userPostsManager?.reloadData = { [weak self] in
            self?.userPostsView?.tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.userPostsView?.tableView.scrollToRow(at: self.indexPath, at: .top, animated: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPostsView?.tableView.reloadData()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Ваши Публикации"
    }

    private func setupPostView() {
        userPostsView = UserPostsView(frame: view.bounds)
        view = userPostsView
        userPostsView?.tableView.delegate = userPostsManager
        userPostsView?.tableView.dataSource = userPostsManager
        userPostsView?.tableView.register(UserPostsTableViewCell.self, forCellReuseIdentifier: UserPostsTableViewCell.reuseIdentifier)
    }
}
