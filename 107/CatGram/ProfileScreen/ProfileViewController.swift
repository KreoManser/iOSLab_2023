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
}
