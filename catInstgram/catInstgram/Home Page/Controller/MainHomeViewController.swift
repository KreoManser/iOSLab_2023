//
//  MainHomeViewController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class MainHomeViewController: UIViewController {

    // MARK: - Variables
    private lazy var mainFeedView = MainHomeView(frame: .zero)

    private let tableViewDataSource = MainHomeUserPostsTableViewDataSource()

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
