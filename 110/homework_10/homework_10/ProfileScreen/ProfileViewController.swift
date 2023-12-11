//
//  ProfileViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView: ProfileView?
    private var profileDataManager: ProfileDataManager?
    private var storyDataManager: StoryDataManager?
    private var coreDataManager = CoreDataManager.shared
    private let logoImage: UIImage

    init(logoImage: UIImage) {
        self.logoImage = logoImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileDataManager = ProfileDataManager.shared
        storyDataManager = StoryDataManager.shared
        setupProfileView()
        setUpNavigationBar()
        profileView?.optionsTapped = {
            let optionsVC = OptionsViewController()
            optionsVC.onDismiss = { [weak self] in
                self?.navigationController?.pushViewController(SettingsViewController(), animated: true)
            }
            self.navigationController?.present(optionsVC, animated: true)
        }
        profileDataManager?.postTapped = { [weak self] indexPath in
            let postViewController = PostsViewController(indexPath: indexPath)
            self?.navigationController?.pushViewController(postViewController, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView?.collectionView.reloadData()
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Профиль"
    }

    private func setupProfileView() {
        profileView = ProfileView(frame: view.bounds, logoImage: logoImage, accountName: coreDataManager.getAuthUser()?.login ?? "")

        profileView?.collectionView.delegate = profileDataManager
        profileView?.collectionView.dataSource = profileDataManager
        profileView?.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)

        profileView?.storiesCollectionView.delegate = storyDataManager
        profileView?.storiesCollectionView.dataSource = storyDataManager
        profileView?.storiesCollectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: StoryCollectionViewCell.reuseIdentifier)

        profileView?.friendsTapped = { [weak self] in
            self?.navigationController?.pushViewController(FriendsViewController(), animated: true)
        }
        view = profileView
    }
}
