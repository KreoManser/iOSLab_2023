//
//  StoryView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryView: UIView {
    weak var controler: StoryViewController?
    var publication: [Publication] = []
    var cat: User?
    lazy var storyImagesColeectionView: UICollectionView = {
        var size = ((UIScreen.main.bounds.size.width) / 4) - 10
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: size, height: size)
        print(((UIScreen.main.bounds.size.width) / 4) - 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.register(
            StoryCollectionViewCell.self,
            forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var tableStoryPosts: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(LentaPostsTableViewCell.self, forCellReuseIdentifier: "LentaPosts")
        return table
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(storyImagesColeectionView)
        addSubview(tableStoryPosts)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            storyImagesColeectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            storyImagesColeectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storyImagesColeectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            storyImagesColeectionView.heightAnchor.constraint(equalToConstant: 100),
            tableStoryPosts.topAnchor.constraint(equalTo: storyImagesColeectionView.bottomAnchor, constant: 10),
            tableStoryPosts.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableStoryPosts.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableStoryPosts.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func setupNavigationBar() {
        controler?.navigationItem.title = "Catgram"
        controler?.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
extension StoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? StoryCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension StoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publication.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableStoryPosts.dequeueReusableCell(
            withIdentifier: "LentaPosts", for: indexPath
        ) as? LentaPostsTableViewCell {
            let publication = publication[indexPath.row]
            cell.isLiked = PublicationDataManager.shared.tryLiked(publicationId: publication.id ?? UUID(), userName: cat?.login ?? "")
            cell.configure(with: publication)
            cell.delegate = controler
            cell.delegateLike = self
            cell.currentPublication = publication
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension StoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 730
    }
}
extension StoryView: PublicationCellLikeDelegate {
    func toggleLike(publicationId: UUID) {
        PublicationDataManager.shared.toggleLike(publicationId: publicationId, userName: cat?.login ?? "")
    }
}
