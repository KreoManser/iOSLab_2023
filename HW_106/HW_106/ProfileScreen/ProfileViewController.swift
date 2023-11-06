//
//  ViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    var profileViewDataSource = ProfileViewDataSource()
    var user: User?

    init(_ user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = profileView
        profileViewDataSource.user = user
        profileView.setupDataSourse(profileViewDataSource)
        profileView.controller = self
        profileView.user = self.user

        guard let user = self.user else { return }
        DispatchQueue.main.async {
            self.profileView.setupProfile(avatar: user.avatarImage,
                subscribers: user.numberOfSubscribers, subscriptions: user.numberOfSubscriptions, name: user.name, description: user.description)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        profileView.photoCollectionView.reloadData()

        guard let user = self.user else { return }
        Task {
            let postsCount = await DataManager.shared.asyncGetPublications(byUserId: user.id)?.count

            await MainActor.run {
                self.profileView.publicationsNumberLabel.text = String(postsCount ?? 0)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "remy_fluffy"
        self.navigationItem.backButtonTitle = ""

    }
}

