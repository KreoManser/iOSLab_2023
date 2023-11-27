//
//  NewsViewController.swift
//  CatGram
//
//  Created by Mac on 2023-11-04.
//

import UIKit

class NewsViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var newsView = NewsView(frame: .zero)
    private var newsDataSourse: NewsViewDataSourse
    private var storiesDataSourse = StoriesDataSourse()
    private let newsManager = NewsManager.newsManager
    private let storiesManager = StoriesManager.storiesManager
    private let loginedUser = UserManager.userManager.loginedUser

    // MARK: - Init
    init() {
        if let user = loginedUser {
            newsManager.createNewsForUserAsync(user: user)
        }
        newsDataSourse = NewsViewDataSourse(manager: newsManager)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Load view
    override func loadView() {
        super.loadView()
        view = newsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.controller = self
        setDataSourse(newsView.storiesCollectionView)
        updateDataSourse()
        newsView.postsTableView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsView.setTableDataSource(newsDataSourse)
        newsView.reloadData()
    }
}

// MARK: - For using in view with alert
extension NewsViewController {
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }
    func delete(indexPath: IndexPath) {
        newsManager.deletePostFromNewsAsync(index: indexPath.row)
        newsView.setTableDataSource(newsDataSourse)
    }
    func like(indexPath: IndexPath) {
        newsManager.likePostAsync(indexPath.row)
        newsView.setTableDataSource(newsDataSourse)
    }
}

extension NewsViewController {
    func setDataSourse(_ storiesCollectionView: UICollectionView) {
        storiesDataSourse.setupDataSourse(storiesCollectionView)
    }
    func updateDataSourse() {
        storiesDataSourse.updateDataSourse(with: storiesManager.stories)
    }
}

