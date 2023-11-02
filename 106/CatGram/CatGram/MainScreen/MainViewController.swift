//
//  ViewController.swift
//  CatGram
//
//  Created by Mac on 2023-10-28.
//

import UIKit

class MainViewController: UIViewController {
    var mainView = MainView(frame: .zero)
    var mainDataSourse = MainViewDataSourse()

    // MARK: - Load view
    override func loadView() {
        view = mainView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSourse()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.controller = self
        setDataSourse(mainView.postsCollectionView)
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
        mainDataSourse.updateDataSourse(with: DataManager.dataManager.getPostsSync())
    }
}

