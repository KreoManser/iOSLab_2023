//
//  ViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 25.10.2023.
//

import UIKit

class ViewController: UIViewController {

    private var profileView: ProfileView?
    private var profileDataManager: ProfileDataManager?
    private var avatarImage: UIImage?

    init(avatarImage: UIImage) {
        self.avatarImage = avatarImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        profileDataManager = ProfileDataManager.shared
        setUpSettings()
        setupNavigationBar()
        profileDataManager?.didSelectPublication = { [weak self] indexPath in
            let detailViewController = DetailViewController(indexPath: indexPath)
            self?.navigationController?.pushViewController(detailViewController, animated: true)
        }
        profileView?.collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView?.collectionView.reloadData()
    }

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = profileView?.buttonName
        navigationItem.rightBarButtonItems = [profileView!.buttonSettings, profileView!.addPublication]
    }

    func setUpSettings() {
        profileView = ProfileView(frame: .zero, avatarImage: self.avatarImage ?? UIImage.eye, userName: AuthorizationDataManager.authUser)
        view = profileView
        profileView?.collectionView.dataSource = profileDataManager
        profileView?.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier)
        profileView?.collectionView.delegate = profileDataManager
    }
}

