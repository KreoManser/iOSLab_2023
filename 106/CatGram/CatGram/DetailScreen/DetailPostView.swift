//
//  DetailPostView.swift
//  CatGram
//
//  Created by Mac on 2023-10-29.
//

import UIKit

class DetailPostView: UIView, UITableViewDelegate {
    weak var controller: DetailPostViewController?
    lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DetailPostTableViewCell.self, forCellReuseIdentifier: DetailPostTableViewCell.reuseIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.delegate = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 560
        return table
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailPostView {
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        postsTableView.dataSource = dataSource
    }

    func reloadData() {
        postsTableView.reloadData()
    }

    func scrollTo(_ postIndex: IndexPath) {
        postsTableView.scrollToRow(at: postIndex, at: .top, animated: true)
    }
}

// MARK: - Constraints
extension DetailPostView {
    private func setupLayouts() {
        addSubview(postsTableView)

        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailPostView: DetailPostAlertDelegate {

    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить пост", message: "Вы действительно хотите удалить этот пост?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        controller?.present(alert)
    }

    func setupSwipeGesture() {
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

