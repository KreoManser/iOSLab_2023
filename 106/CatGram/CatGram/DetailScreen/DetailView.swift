//
//  DetailView.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import UIKit

class DetailView: UIView {

    lazy var postsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailTableViewCell.self,
        forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
        return tableView
    }()

    weak var controller: DetailViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(postsTableView)
        setUpLayout()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {

    func setupDataSource(_ dataSource: UITableViewDataSource) {
        postsTableView.dataSource = dataSource
    }

    func reloadData() {
        postsTableView.reloadData()
    }

    func scrollToIndexPath(_ indexPath: IndexPath) {
        postsTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DetailView: PostTableViewCellDelegate {

    func didDeletePost(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить пост", message: "Вы уверены?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
            self?.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        controller?.present(alert)
    }

    func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            controller?.dismissScreen()
        }
    }
}
