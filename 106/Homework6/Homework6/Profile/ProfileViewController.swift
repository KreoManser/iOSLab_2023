//
//  ViewController.swift
//  Homework6
//
//  Created by kerik on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var profileView: ProfileView = ProfileView(viewWidth: view.frame)
    private let dataSource = CollectionViewDataSource()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
        profileView.updateProfileData(with: DataManager.shared.syncGetCurrentUser())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        view.backgroundColor = .white
        profileView.controller = self
        profileView.setupDataSource(dataSource)
        configureProfileViewOnView()
        Task {
            await setNavigationBar()
        }

        Task {
            await profileView.configureProfile(with: DataManager.shared.asyncGetCurrentUser())
        }
    }

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        let postsViewtController = PostsViewController(postIndexPath)
        postsViewtController.modalPresentationStyle = .fullScreen
        present(postsViewtController, animated: true)
    }
}

extension ProfileViewController {
    private func setNavigationBar() async {
        let profileNameLabel = UILabel()
        profileNameLabel.text = await DataManager.shared.asyncGetCurrentUser().login
        profileNameLabel.textColor = .black
        profileNameLabel.font = .boldSystemFont(ofSize: 25)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileNameLabel)

        let rightButton1 = UIButton(type: .custom)
        rightButton1.setImage(UIImage(named: "addIcon"), for: .normal)
        let firstRightBarButton = UIBarButtonItem(customView: rightButton1)

        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 20

        let rightButton2 = UIButton(type: .custom)
        rightButton2.setImage(UIImage(named: "hamburger"), for: .normal)
        let secondRightBarButton = UIBarButtonItem(customView: rightButton2)

        navigationItem.rightBarButtonItems = [secondRightBarButton, fixedSpace, firstRightBarButton]
    }

    private func configureProfileViewOnView() {
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController {
    func setExitAction() {
        let alert = UIAlertController(
            title: "Выход",
            message: "Вы точно хотите выйти?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            self.navigationController?.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
}
