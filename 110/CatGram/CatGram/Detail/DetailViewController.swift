//
//  UIDetailViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 30.10.2023.
//

import UIKit

class DetailViewController: UIViewController, CreatingPublicationViewDelegate, CreatingPublicationControllerDelegate {

    private var detailView: DetailView?
    private var detailDataManager: DetailDataManager!
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
        detailDataManager = DetailDataManager.shared

        detailDataManager?.setCompletionHandler {
            self.detailView?.tableView.reloadData()
        }
        setupNavigationBar()

        setupSettings()
        detailDataManager?.reloadData = { [weak self] in
            self?.detailView?.tableView.reloadData()
        }
        let login = UserDefaults.standard.object(forKey: "user") as? String
        guard let userName = login else { return }
        detailDataManager?.optionsTapped = { [weak self] alertController in
            guard let self = self else { return }
            let action = UIAlertAction(title: "Обновить публикацию ", style: .default) { _ in
                let row = self.indexPath.row
                guard var publications = self.detailDataManager.detailPublication[userName], row < publications.count else {
                    return
                }
                let update = UpdatePublicationViewController(publication: &publications[row], indexPath: self.indexPath)
                self.navigationController?.pushViewController(update, animated: true)
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.detailView?.tableView.reloadData()
        }
        detailDataManager?.reloadData = { [weak self] in
            self?.detailView?.tableView.reloadData()
        }
        print("IndexPath before scrolling: \(self.indexPath)")
        DispatchQueue.main.async {
            let numberOfRows = self.detailView?.tableView.numberOfRows(inSection: 0) ?? 0
            if numberOfRows > 0 {
                self.detailView?.tableView.scrollToRow(at: self.indexPath, at: .top, animated: false)
            }
        }
        detailDataManager?.reloadData = { [weak self] in
            self?.detailView?.tableView.reloadData()
        }
    }
    func setupNavigationBar() {
        navigationItem.title = "Публикации"
        navigationController?.navigationBar.backgroundColor = .white
    }

    func savePublication() {
        detailView?.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.detailView?.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.detailView?.tableView.reloadData()
    }

    func reloadData() {
        detailView?.tableView.reloadData()
    }

    func setupSettings() {
        detailView = DetailView(frame: view.bounds, indexPath: indexPath)
        view = detailView
        detailView?.tableView.dataSource = detailDataManager
        detailView?.tableView.delegate = detailDataManager
        detailView?.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }
}
