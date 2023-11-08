//
//  FeedViewController.swift
//  Homework6
//
//  Created by kerik on 07.11.2023.
//

import UIKit

class FeedViewController: UIViewController {
    private lazy var mainFeedView = FeedView(frame: .zero)
    private let tableViewDataSource = FeedTableViewDataSoure()
    private let collectionViewDataSource = StoriesDataSource()

    override func loadView() {
        view = mainFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainFeedView.setupTableViewDataSourse(tableViewDataSource)
        mainFeedView.setupCollectionViewDataSource(collectionViewDataSource)
        navigationItem.title = "CatGram"
    }
}
