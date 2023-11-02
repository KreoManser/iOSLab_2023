//
//  ProfileViewController.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 31.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView = ProfileView(frame: .zero)

    private var dataSource = ProfileDataManager()

    override func loadView() {
        view = profileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = ProfileDataManager.shared
        profileView.controller = self
        profileView.setupDataSourse(dataSource)

    }

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        let presentController = DetailViewController(postIndexPath)
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }
}
