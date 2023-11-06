//
//  UIDetailViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 30.10.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private var detailView: DetailView?
    private var detailDataManager: DetailDataManager?
    private var indexPath: IndexPath

    init(indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailDataManager = DetailDataManager()
        setupNavigationBar()

        setupSettings()
        detailDataManager?.optionsTapped = { [weak self] alertController in
            self?.present(alertController, animated: true, completion: nil)
        }
        detailDataManager?.reloadData = { [weak self] in
            self?.detailView?.tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.detailView?.tableView.scrollToRow(at: self.indexPath, at: .top, animated: false)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = "Публикации"
        navigationController?.navigationBar.backgroundColor = .white
    }

    func setupSettings() {
        detailView = DetailView(frame: view.bounds, indexPath: indexPath)
        view = detailView
        detailView?.tableView.dataSource = detailDataManager
        detailView?.tableView.delegate = detailDataManager
        detailView?.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }
}
