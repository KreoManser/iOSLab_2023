//
//  MainViewController.swift
//  HW106
//
//  Created by Тимур Хайруллин on 07.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView(frame: .zero)
    private let mainPostsTableViewDataSource = MainPostsTableViewDataSource()
    private let storiesCollectionViewDataSource = StoriesCollectionViewDataSource()
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setupPostTableViewDataSource(mainPostsTableViewDataSource)
        mainView.setupStoriesCollectionViewDataSource(storiesCollectionViewDataSource)
    }
}
