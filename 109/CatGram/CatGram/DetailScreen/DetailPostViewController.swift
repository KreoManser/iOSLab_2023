//
//  DetailPostViewController.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class DetailPostViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var detailPostView = DetailPostView(frame: .zero)
    private lazy var detailDataSourse = DetailPostViewDataSourse()
    private let manager = PostsManager.postsManager
    private let loginedUser = UserManager.userManager.loginedUser
    var currentPost: IndexPath?

    // MARK: - Init
    init() {
        if let user = loginedUser {
            manager.configurePosts(user: user)
        }
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Load view
    override func loadView() {
        super.loadView()
        view = detailPostView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPostView.controller = self
        detailPostView.postsTableView.allowsSelection = false
        setupSwipeGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = loginedUser {
            manager.configurePosts(user: user)
        }
        detailPostView.setTableDataSource(detailDataSourse)
        detailPostView.scrollTo(currentPost ?? IndexPath(index: 0))
    }
}

// MARK: - Search Bar for view funcs
extension DetailPostViewController {
    func getSearchedPostsCount() -> Int {
        return manager.postWithFilter.count
    }

    func searchPostsByName(_ name: String) {
        manager.searchByNameAsync(name)
    }
}

// MARK: - ObjC for dismiss screen
extension DetailPostViewController {
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }

    @objc private func handleSwipeGesture() {
        dismiss(animated: true, completion: nil)
    }
    func dismissScreen() {
        dismiss(animated: true)
    }
}

// MARK: - For using in view with alert
extension DetailPostViewController {
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func delete(indexPath: IndexPath) {
        manager.deletePostAsync(indexPath.row)
        detailPostView.setTableDataSource(detailDataSourse)
    }

    func like(indexPath: IndexPath) {
        manager.likePostAsync(indexPath.row)
        detailPostView.setTableDataSource(detailDataSourse)
    }
}
