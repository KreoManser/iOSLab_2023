//
//  FeedViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import UIKit

class FeedViewController: UIViewController {

    let feedView = FeedView()
    let feedCollectionViewDataSource = FeedCollectionViewDataSource()
    let feedTableViewDataSource = FeedPostsTableViewDataSource()
    var user: User?

    init(_ user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = feedView
        feedView.controller = self
        feedView.setupDataSourse(feedCollectionViewDataSource, feedTableViewDataSource)
        feedTableViewDataSource.user = self.user
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        feedView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Лента"
    }
}

extension FeedViewController {
    func presentAlert(_ indexPath: IndexPath) {
        guard let user = self.user else { return }
        let dataManager = DataManager.shared
        guard user.id == dataManager.syncGetAllPublications()[indexPath.row].userId else { return }

        let alertController = UIAlertController(title: "Удалить публикацию",
            message: "Вы действительно хотите удалить эту публикацию?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            dataManager.asyncDeletePublication(withIndex: indexPath.row, completion: {
                self?.feedView.reloadData()
            })
        }

        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        present(alertController, animated: true, completion: nil)
    }
}
