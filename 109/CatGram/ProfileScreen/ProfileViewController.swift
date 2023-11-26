//
//  ProfileViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView: ProfileView?
    var profiledataManager: ProfileDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        profiledataManager = ProfileDataManager.shared
        setUpView()
        setUpNavbar()

        profiledataManager?.didTapImage = { [weak self] _ in
            print("Tapped an image")
            let publicationdetailViewController = PublicationsViewController()
            self?.navigationController?.pushViewController(publicationdetailViewController, animated: true)
        }
        self.profiledataManager?.reloadcollectionData = { [weak self] in
            DispatchQueue.main.async {
                self?.profileView?.collectionView.reloadData()
            }
        }
        profileView?.didTapSettingsButton = { [weak self] in
            let viewController = SettingsViewController()
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        profileView?.settingsButton.addTarget(self, action: #selector(didTapsettingsButton), for: .touchUpInside)

        profileView?.didTapfollowingButton = { [weak self] in
            let friendsController = FriendsViewController()
            self?.navigationController?.pushViewController(friendsController, animated: true)
        }
        profileView?.followingButton.addTarget(self, action: #selector(didTapFollwersButton), for: .touchUpInside)
        profileView?.followersButton.addTarget(self, action: #selector(didTapFollwersButton), for: .touchUpInside)
    }
    private func setUpView() {
        profileView = ProfileView(frame: view.bounds)
        profileView?.collectionView.delegate = profiledataManager
        profileView?.collectionView.dataSource = profiledataManager
        profileView?.collectionView.register(
        ProfileCollectionViewCell.self,
        forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseidentifier
        )
        view = profileView
        view.backgroundColor = .white
    }
    private func setUpNavbar() {
        navigationItem.title = "PROFILE"
        navigationItem.largeTitleDisplayMode = .always
    }
   @objc  private func  didTapsettingsButton() {
        profileView?.didTapSettingsButton!()
    }
    @objc private func didTapFollwersButton() {
        profileView?.didTapfollowingButton!()
    }
}
