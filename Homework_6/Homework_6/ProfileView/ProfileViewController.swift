//
//  ProfileViewController.swift
//  Homework_6
//
//  Created by err on 05.11.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView: ProfileView?
    private var profileDataManager: ProfileDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        profileDataManager = ProfileDataManager.shared
        setupShopView()
        profileDataManager?.postTapped = { [weak self] indexPath in
            let postViewController = PostsViewController(indexPath: indexPath)
            self?.navigationController?.pushViewController(postViewController, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView?.collectionView.reloadData()
    }
    private func setupShopView() {
        profileView = ProfileView(frame: view.bounds)
        profileView?.collectionView.delegate = profileDataManager
        profileView?.collectionView.dataSource = profileDataManager
        profileView?.collectionView.register(ProfileCollectionViewCell.self,
                                             forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        view = profileView
    }
}
