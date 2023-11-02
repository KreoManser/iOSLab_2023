//
//  DetailViewController.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private var indexPath: IndexPath

    private lazy var pictureDetailView = DetailView(frame: .zero)

    private let dataSource = DetailDataManager()

    init(_ indexPathToScroll: IndexPath) {
        self.indexPath = indexPathToScroll
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = pictureDetailView
        pictureDetailView.setupDataSource(dataSource)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pictureDetailView.scrollToIndexPath(self.indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pictureDetailView.controller = self
    }
}

extension DetailViewController {
    func present(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func delete(indexPath: IndexPath) {
        DetailDataManager.shared.deletePost(index: indexPath.row)
        pictureDetailView.reloadData()
    }

    func dismissScreen() {
        dismiss(animated: true)
    }

}
