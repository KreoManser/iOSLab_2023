//
//  UserProfilePostsViewController.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 22.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Variables
    private var profileView = ProfileView(frame: .zero)

    private let dataSourse = UserProfilePostsCollectionViewDataSource()

    private let dataManager = DataManager.shared

    // MARK: - Life cycle
    override func loadView() {
        view = profileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let currentUser = dataManager.currentUser else { return }
        profileView.reloadData()
        profileView.updateProfileData(with: currentUser)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.controller = self
        profileView.setupDataSourse(dataSourse)
        guard let currentUser = dataManager.currentUser else { return }
        profileView.configureProfile(with: currentUser)
    }

}

extension ProfileViewController {

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        let presentController = UserProfilePostsViewController(postIndexPath)
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }

    func presentSettingsScreen() {
        present(SettingsViewController(), animated: true)
    }
}
