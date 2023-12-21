//
//  NewsLineView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 01.12.2023.
//

import UIKit
import CoreData

class NewsLineView: UIView {
    weak var newsLineVC: NewsLineViewController?
    let coreDataManager = CoreDataManager.shared
    var fetchedResultController: NSFetchedResultsController<Post>!
    lazy var newsLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CatGram"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    lazy var newsLineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(NewsLineCollectionViewCell.self, forCellWithReuseIdentifier: "newsLineCollectionCell")
        return collectionView
    }()
    lazy var newsLineTablewView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsLineTableViewCell.self, forCellReuseIdentifier: "newsLineTableCell")
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchedResultController = NSFetchedResultsController()
        fetchedResultController.delegate = self
        self.backgroundColor = .white
        addSubview(newsLineLabel)
        addSubview(newsLineCollectionView)
        addSubview(newsLineTablewView)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateTableWithCachedData() {
        do {
            try fetchedResultController.performFetch()
            newsLineTablewView.reloadData()
        } catch {
            print("Fetch request failed with error: \(error)")
        }
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            newsLineLabel.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            newsLineLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            newsLineCollectionView.topAnchor.constraint(equalTo: newsLineLabel.bottomAnchor, constant: 5),
            newsLineCollectionView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            newsLineCollectionView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            newsLineCollectionView.heightAnchor.constraint(equalToConstant: 100),
            newsLineTablewView.topAnchor.constraint(equalTo: newsLineCollectionView.bottomAnchor, constant: 10),
            newsLineTablewView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            newsLineTablewView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            newsLineTablewView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    func setupDataSourse(collectiondataSource: NewsLineCollectionDataSource,
                         tableDataSource: NewsLineTableDataSource) {
        newsLineCollectionView.dataSource = collectiondataSource
        newsLineTablewView.dataSource = tableDataSource
    }
    func reloadData() {
        newsLineTablewView.reloadData()
    }
}
extension NewsLineView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            newsLineTablewView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            newsLineTablewView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}

extension NewsLineView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NewsLineView: AllertConnectionNewsLine {
    func tapLikeButton(postId: Int, userId: Int) {
        self.newsLineVC?.tapLikeButton(postId: postId, userId: userId)
        self.reloadData()
    }
    func presentAllertVC(postId: Int, postUserId: Int) {
        if postUserId == coreDataManager.getAuthorizationUser().userId {
            let alertVC = UIAlertController(title: "Внимание",
                message: "Вы уверены что хотите удлаить этот пост?",
                preferredStyle: .actionSheet)
            let deleteAlertButton = UIAlertAction(title: "Удалить",
                style: .destructive, handler: { [weak self] _ in
                    self?.newsLineVC?.deletePost(postId: postId,
                                                 postUserId: postUserId)
                    self?.reloadData()})
            let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
            alertVC.addAction(deleteAlertButton)
            alertVC.addAction(cancelAlertButton)
            newsLineVC?.present(alertVC, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Извини",
                message: "Это не твой пост :). Ты не можешь его удалить",
                preferredStyle: .actionSheet)
            let cancelAlertButton = UIAlertAction(title: "Отмена", style: .cancel)
            alertVC.addAction(cancelAlertButton)
            newsLineVC?.present(alertVC, animated: true)
        }
    }
}
