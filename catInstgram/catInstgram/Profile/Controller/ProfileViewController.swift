//
//  ProfileViewController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Variables
    private var profileView = ProfileView(frame: .zero)

    private let dataSourse = UserProfilePostsCollectionViewDataSource()

    // MARK: - Life cycle
    override func loadView() {
        view = profileView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        profileView.reloadData()
        profileView.updateProfileData(with: DataManager.shared.syncGetCurrentUser())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.controller = self
        profileView.setupDataSourse(dataSourse)

        Task {
            await profileView.configureProfile(with: DataManager.shared.asyncGetCurrentUser())
        }

    }

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        let presentController = UserProfilePostsViewController(postIndexPath)
        presentController.modalPresentationStyle = .fullScreen
        present(presentController, animated: true)
    }
}
