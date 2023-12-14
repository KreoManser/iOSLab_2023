//
//  PublicationView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

class PostsView: UIView {
    weak var publicationViewController: PostsViewController?
    lazy var publicationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Ведите текст"
        searchBar.backgroundColor = .white
        searchBar.delegate = self
        return searchBar
    }()
    lazy var publicationTableView: UITableView = {
        let tableVC = UITableView()
        tableVC.register(PostsTableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableVC.translatesAutoresizingMaskIntoConstraints = false
        return tableVC
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(publicationTableView)
        addSubview(publicationSearchBar)
        setupLayout()
        setupSwipeRecognized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            publicationSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            publicationSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            publicationSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            publicationTableView.topAnchor.constraint(equalTo: publicationSearchBar.bottomAnchor, constant: 20),
            publicationSearchBar.heightAnchor.constraint(equalToConstant: 30),
            publicationTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            publicationTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            publicationTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setupDataSource(dataSource: PostsDataSource) {
        publicationTableView.dataSource = dataSource
    }
    func reloadData() {
        publicationTableView.reloadData()
    }
    func setupSwipeRecognized() {
        let swipeRecognized = UISwipeGestureRecognizer(target: self, action: #selector(self.handelSwipe))
        swipeRecognized.direction = .right
        addGestureRecognizer(swipeRecognized)
    }
    func scrollToSellectedCell(indexPath: IndexPath) {
        publicationTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    @objc func handelSwipe(sender: UISwipeGestureRecognizer) {
        publicationViewController?.dismisPublicationVC()
    }
}

extension PostsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            reloadData()
        }
}

extension PostsView: AllertConnection {
    func tapLikeButton(postId: Int, userId: Int) {
        self.publicationViewController?.tapLikeButton(postId: postId, userId: userId)
        self.reloadData()
    }
    func presentAllertVC(postId: Int, userId: Int) {
        let alertVC = UIAlertController(title: "Внимание",
            message: "Вы уверены что хотите удлаить этот пост?",
            preferredStyle: .actionSheet)
        let deleteAlertButton = UIAlertAction(title: "Удалить",
            style: .destructive, handler: { [weak self] _ in
                self?.publicationViewController?.deletePost(postId: postId, userId: userId)
                self?.reloadData()})
        let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(deleteAlertButton)
        alertVC.addAction(cancelAlertButton)
        publicationViewController?.present(alertVC, animated: true)
    }
}
