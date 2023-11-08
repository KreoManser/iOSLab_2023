//
//  PostsViewController.swift
//  Homework6
//
//  Created by kerik on 30.10.2023.
//

import UIKit

class PostsViewController: UIViewController {
    private lazy var pictureDetailView = PostsView(frame: .zero)

    private var indexPath: IndexPath?

    let dataSource = TableViewDataSource()

    override func loadView() {
        view = pictureDetailView
        pictureDetailView.setupDataSource(dataSource)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = self.indexPath {
            pictureDetailView.scrollToIndexPath(indexPath)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pictureDetailView.controller = self
    }

    init(_ indexPathToScroll: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.indexPath = indexPathToScroll
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsViewController {
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func delete(indexPath: IndexPath) {
        Task {
            await DataManager.shared.asyncDelete(index: indexPath.row)
            pictureDetailView.reloadData()
        }
    }

    func dismissScreen() {
        dismiss(animated: true)
    }

    func getSearchedPostsConunt() -> Int {
        return DataManager.shared.searchedPostsCount
    }

    func searchPostsByDescription(_ description: String) {
        DataManager.shared.syncSearchByDescription(description)
    }
}
