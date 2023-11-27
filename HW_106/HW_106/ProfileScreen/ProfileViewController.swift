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
        self.navigationItem.backButtonTitle = "Back"
        setupNavigationBar()
    }

    func setupNavigationBar() {

        let leaveAlertAction = UIAction { [weak self] _ in
            self?.presentLeaveAlert()
        }

        let leaveButton = UIBarButtonItem(systemItem: .stop, primaryAction: leaveAlertAction)

        navigationItem.rightBarButtonItem = leaveButton

    }

    func presentLeaveAlert() {

        let alertController = UIAlertController(title: "Выйти из аккаунта",
            message: "Вы действительно хотите выйти из аккаунта?", preferredStyle: .alert)

        let leaveAction = UIAlertAction(title: "Выйти", style: .destructive) { _ in

            UserDefaults.standard.removeObject(forKey: "logged_in")

            let loginViewController = LoginViewController()

            let navigationController = UINavigationController(rootViewController: loginViewController)

            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }

        alertController.addAction(leaveAction)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        present(alertController, animated: true, completion: nil)
    }
}

