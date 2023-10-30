//
//  ViewController.swift
//  CatGram
//
//  Created by Mac on 2023-10-28.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Declaration objects
    var mainView = MainView(frame: .zero)
    var mainDataSourse = MainViewDataSourse()
    lazy var posts = DataManager.dataManager.getPostsSync()

    // MARK: - Load view
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.controller = self
        setDataSourse(mainView.postsCollectionView)
        updateDataSourse()
    }
}

// MARK: - Diffable Data Sourse
extension MainViewController {
    func showDetailScreen(_ indexPath: IndexPath) {
        let detailVC = DetailPostViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.currentPost = indexPath
        self.present(detailVC, animated: true, completion: nil)
    }
    func setDataSourse(_ postsCollectionView: UICollectionView) {
        mainDataSourse.setupDataSourse(postsCollectionView)
    }
    func updateDataSourse() {
        mainDataSourse.updateDataSourse(with: posts)
    }
}

