//
//  PublicationView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

class PublicationView: UIView {
    weak var publicationViewController: PublicationViewController?
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
        tableVC.register(PublicationTableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableVC.translatesAutoresizingMaskIntoConstraints = false
        return tableVC
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            publicationSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            publicationSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            publicationSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            publicationTableView.topAnchor.constraint(equalTo: publicationSearchBar.bottomAnchor, constant: 10),
            publicationSearchBar.heightAnchor.constraint(equalToConstant: 30),
            publicationTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            publicationTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            publicationTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setupDataSource(dataSource: PublicationDataSource) {
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

extension PublicationView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            publicationViewController?.searchPostsByName(name: searchText)
            guard let text = searchBar.text else { return }
            if text.isEmpty {
                DataManager.sigelton.isSearching = false
            } else {
                DataManager.sigelton.isSearching = true
            }
            reloadData()
        }
}

extension PublicationView: AllertConnection {
    func presentAllertVC(indexPath: IndexPath) {
        let alertVC = UIAlertController(title: "Внимание",
            message: "Вы уверены что хотите удлаить этот пост?",
            preferredStyle: .actionSheet)
        let deleteAlertButton = UIAlertAction(title: "Удалить",
            style: .destructive, handler: { [weak self] _ in self?.publicationViewController?.deletePost(
                indexPath: indexPath)})
        let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(deleteAlertButton)
        alertVC.addAction(cancelAlertButton)
        publicationViewController?.present(alertVC, animated: true)
    }
}
