//
//  NewsView.swift
//  CatGram
//
//  Created by Mac on 2023-11-04.
//

import UIKit

class NewsView: UIView, UITableViewDelegate, UICollectionViewDelegate, UIScrollViewDelegate {
    // MARK: - Declaration objects
    weak var controller: NewsViewController?
    private var storiesCollectionViewTopConstraint = NSLayoutConstraint()

    lazy var storiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let spacing: CGFloat = 20

        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: 80, height: 80)

        let stories = UICollectionView(frame: .zero, collectionViewLayout: layout)
        stories.translatesAutoresizingMaskIntoConstraints = false
        stories.backgroundColor = .white
        stories.delegate = self
        stories.register(StoryViewCell.self, forCellWithReuseIdentifier: StoryViewCell.reuseIdentifier)
        stories.showsHorizontalScrollIndicator = false
        return stories
    }()
    lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostViewCell.self, forCellReuseIdentifier: PostViewCell.reuseIdentifier)
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

// MARK: - Custom DetailPostAlertDelegate
extension NewsView: DetailPostAlertDelegate {
    func presentAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить котикса", message: "Удалить котика :(?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: {  [weak self] _ in
            self?.controller?.delete(indexPath: indexPath)
            self?.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Не надо..", style: .cancel))
        controller?.present(alert)
    }
}

// MARK: - Table Info with system methods
extension NewsView {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension NewsView: LikePostDelegate {
    func likePost(indexPath: IndexPath) {
        self.controller?.like(indexPath: indexPath)
        self.reloadData()
    }
}

// MARK: - Table Info with personal metiods
extension NewsView {
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        postsTableView.dataSource = dataSource
    }
    func reloadData() {
        self.postsTableView.reloadData()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == postsTableView {
            if scrollView.contentOffset.y < 30 {
                storiesCollectionViewTopConstraint.constant = 10
                storiesCollectionView.isHidden = false
            } else {
                storiesCollectionViewTopConstraint.constant = -120
                storiesCollectionView.isHidden = true
            }
        }
    }
}

// MARK: - Constraints
extension NewsView {
    private func setupLayouts() {
        addSubview(storiesCollectionView)
        addSubview(postsTableView)

        storiesCollectionViewTopConstraint = storiesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)

        NSLayoutConstraint.activate([
            storiesCollectionViewTopConstraint,
            storiesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            storiesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            storiesCollectionView.heightAnchor.constraint(equalToConstant: 95),

            postsTableView.topAnchor.constraint(equalTo: storiesCollectionView.bottomAnchor, constant: 5),
            postsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
