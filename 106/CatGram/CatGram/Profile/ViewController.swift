//
//  ViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.10.2023.
//

import UIKit

class ViewController: UIViewController {

    private var profileView = ProfileView(frame: .zero)
    private var profileDataManager: ProfileDataManager?

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileDataManager = ProfileDataManager.shared
        setUpSettings()
        setupNavigationBar()
        profileDataManager?.didSelectPublication = { [weak self] indexPath in
            let detailViewController = DetailViewController(indexPath: indexPath)
            self?.navigationController?.pushViewController(detailViewController, animated: true)
        }
        profileView.collectionView?.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.collectionView?.reloadData()
    }

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = profileView.buttonName
        navigationItem.rightBarButtonItems = [profileView.buttonSettings, profileView.addPublication]
    }

    func setUpSettings() {
        profileView.collectionView.dataSource = profileDataManager
        profileView.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        profileView.collectionView.delegate = profileDataManager
    }
}

