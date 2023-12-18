//
//  PostsViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class PostsViewController: UIViewController {

    private var postView: PostsView?
    private var postDataManager: PostsDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        postDataManager = PostsDataManager()
        setUpNavigationBar()
        setupPostView()
        postDataManager?.optionsTapped = { [weak self] alertController in
            self?.present(alertController, animated: true, completion: nil)
        }
        postDataManager?.reloadData = { [weak self] in
            self?.postView?.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postView?.tableView.reloadData()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Публикации"
    }

    private func setupPostView() {
        postView = PostsView(frame: view.bounds)
        view = postView
        postView?.tableView.delegate = postDataManager
        postView?.tableView.dataSource = postDataManager
        postView?.postSearchBar.delegate = postDataManager
        postView?.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
    }
}

