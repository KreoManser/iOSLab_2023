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
    private lazy var mainController = MainViewDataSourse()
    private let manager = DataManager.dataManager
    var currentPost: IndexPath?

    // MARK: - Load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailPostView.setTableDataSource(detailDataSourse)
        detailPostView.scrollTo(currentPost ?? IndexPath(index: 0))
    }
    override func loadView() {
        super.loadView()
        detailPostView.setTableDataSource(detailDataSourse)
        view = detailPostView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPostView.controller = self
        detailPostView.postsTableView.allowsSelection = false
        setupSwipeGesture()
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
        manager.deleteSync(index: indexPath.row)
        detailPostView.setTableDataSource(detailDataSourse)
    }
}
