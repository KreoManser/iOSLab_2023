//
//  MainFeedViewController.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 04.11.2023.
//

import UIKit

class MainFeedViewController: UIViewController {

    // MARK: - Variables
    private lazy var mainFeedView = MainFeedView(frame: .zero)

    private let tableViewDataSource = MainFeedUserPostsTableViewDataSource()

    private let collectionViewDataSource = UserStoriesCollectionViewDataSource()

    // MARK: - Life cycle
    override func loadView() {
        view = mainFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainFeedView.setupTableViewDataSourse(tableViewDataSource)
        mainFeedView.setupCollectionViewDataSource(collectionViewDataSource)
    }

}
