//
//  PostsViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 31.10.2023.
//

import UIKit

class PostsViewController: UIViewController {

    let postsView = PostsView()
    let postsViewDataSource = PostsViewDataSource.shared
    private var indexPath: IndexPath?

    init(_ index: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.indexPath = index
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        postsView.scrollToIndexPath(self.indexPath ?? IndexPath(row: 0, section: 0))
    }

    override func loadView() {
        view = postsView
        postsView.controller = self
        postsView.setupDataSourse(postsViewDataSource)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Публикации"
        view.backgroundColor = .white
    }
}

extension PostsViewController {

    func presentAlert(_ indexPath: IndexPath) {

        let dataManager = DataManager.shared

        let alertController = UIAlertController(title: "Удалить публикацию",
            message: "Вы действительно хотите удалить эту публикацию?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            dataManager.asyncDeletePublication(withIndex: indexPath.row)
            self?.postsView.reloadData()
        }

        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        present(alertController, animated: true, completion: nil)
    }
}
