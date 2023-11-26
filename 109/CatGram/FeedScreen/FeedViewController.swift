//
//  FeedViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import UIKit

class FeedViewController: UIViewController {

    var feedView: FeedView?
    var feedDatamanger: FeedDataManager?
    var storyDatamanager: StoryDataManager?
    var loginDataManager: UserDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        feedDatamanger = FeedDataManager.shared
        storyDatamanager = StoryDataManager.shared
        setUpView()
        setUpNavbar()

        self.feedDatamanger?.reloadtableView = { [weak self] in
            DispatchQueue.main.async {
                self?.feedView?.tableView.reloadData()
            }
        }
    }

    private func setUpView() {
        feedView = FeedView(frame: view.bounds)
        feedView?.circularCollectionView.collectionView.delegate = storyDatamanager
        feedView?.circularCollectionView.collectionView.dataSource = storyDatamanager
        feedView?.circularCollectionView.isHidden = false
        feedView?.circularCollectionView.collectionView.register(
        StoryCollectionViewCell.self,
        forCellWithReuseIdentifier: StoryCollectionViewCell.storyID
        )
        feedView?.circularCollectionView.collectionView.showsHorizontalScrollIndicator = false
        feedView?.tableView.delegate = feedDatamanger
        feedView?.tableView.dataSource = feedDatamanger
        feedView?.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.reuseIdentifiers)
        view = feedView
        view.backgroundColor = .white
    }
    private func setUpNavbar() {
        navigationItem.title = "FEED"
        navigationItem.largeTitleDisplayMode = .always
    }

}
