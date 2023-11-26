//
//  UserProfilePostsViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class UserProfilePostsViewController: UIViewController {
    // MARK: - Variables
    private lazy var pictureDetailView = UserProfilePostsView(frame: .zero)

    private var indexPath: IndexPath?

    private let dataSource = UserProfilePostsTableViewDataSource()

    private let dataManager = DataManager.shared

    // MARK: - Life cycle
    override func loadView() {
        view = pictureDetailView

        pictureDetailView.setupDataSource(dataSource)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        pictureDetailView.scrollToIndexPath(self.indexPath ?? IndexPath(row: 0, section: 0))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pictureDetailView.controller = self
    }

    // MARK: - Init
    init(_ indexPathToScroll: IndexPath) {
        super.init(nibName: nil, bundle: nil)

        self.indexPath = indexPathToScroll
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserProfilePostsViewController {
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func delete(indexPath: IndexPath) {
        Task {
            await dataManager.asyncDeletePost(index: indexPath.row)
            pictureDetailView.reloadData()
        }
    }

    func dismissScreen() {
        dismiss(animated: true)
    }

    func getSearchedPostsConunt() -> Int {
        return dataManager.filteredPostsCount
    }

    func searchPostsByName(_ name: String) {
        dataManager.syncSearchByName(name)
    }

}
