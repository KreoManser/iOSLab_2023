//
//  ProfileViewController.swift
//  InstaCat
//
//  Created by Камил Хайрутдинов on 28.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Variables
    private var profileView = ProfileView(frame: .zero)

    private let dataSourse = CollectionViewDataSource()

    // MARK: - Life cycle
    override func loadView() {
        view = profileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.controller = self
        profileView.setupDataSourse(dataSourse)
    }

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        print(postIndexPath)
        let presentController = PostsViewController(postIndexPath)
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }
}
