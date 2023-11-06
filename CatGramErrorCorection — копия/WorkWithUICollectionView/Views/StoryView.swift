//
//  StoryView.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryView: UIView {
    weak var controler: StoryViewController?
    var publishers: [Publisher] = [
        Publisher(id: "1", description: "Description 1", date: "4 июня", image: UIImage(named: "photo1")),
        Publisher(id: "2", description: "Description 2", date: "21 августа", image: UIImage(named: "photo2")),
        Publisher(id: "3", description: "Description 3", date: "20 июля", image: UIImage(named: "photo3"))
    ]
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
//        collectionView.delegate = self
        return collectionView
    }()
    lazy var tableStoryPosts: UITableView =  {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(PublisherTableViewCell.self, forCellReuseIdentifier: "Publisher")
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
            tableStoryPosts.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    func setupNavigationBar() {
        controler?.navigationItem.title = "Catgram"
        //navigationItem.titleView?.backgroundColor = .black
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
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as! StoryCollectionViewCell
            return cell
    }
}
extension StoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableStoryPosts.dequeueReusableCell(
            withIdentifier: "Publisher", for: indexPath
        ) as? PublisherTableViewCell {
            let publisher = publishers[indexPath.row]
            cell.configure(with: publisher)
            //cell.delegate = self
            cell.currentPublisher = publisher
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
