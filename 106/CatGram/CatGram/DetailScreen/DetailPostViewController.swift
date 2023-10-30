//
//  DetailPostViewController.swift
//  CatGram
//
//  Created by Mac on 2023-10-30.
//

import UIKit

class DetailPostViewController: UIViewController {
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    private lazy var detailPostView = DetailPostView(frame: .zero)
    private lazy var dataManager = DataManager.dataManager
    private lazy var posts = dataManager.getPostsSync()
    private lazy var detailDataSourse = DetailPostViewDataSourse(posts)
    var currentPost: IndexPath?

    // MARK: - Load view
    override func loadView() {
        view = detailPostView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPostView.setTableDataSource(detailDataSourse)
        setupSwipeGesture()
        detailPostView.scrollTo(currentPost ?? IndexPath(index: 0))
    }
}

// MARK: - ObjC
extension DetailPostViewController {
    private func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }

    @objc private func handleSwipeGesture() {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailPostViewController {
    func present(_ controller: UIViewController) {
         present(controller, animated: true)
         show(controller, sender: nil)
     }

     func delete(indexPath: IndexPath) {
         dataManager.deleteSync(index: indexPath.row)
         detailPostView.reloadData()
     }

     func dismissScreen() {
         dismiss(animated: true)
     }
}
