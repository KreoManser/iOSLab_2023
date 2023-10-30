//
//  ViewController.swift
//  Homework6
//
//  Created by kerik on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var mainView: ProfileView = ProfileView(viewWidth: view.frame)
    private let dataSourse = CollectionViewDataSource()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        view.backgroundColor = .white
        mainView.controller = self
        mainView.setupDataSourse(dataSourse)
        configureProfileViewOnView()
        setNavigationBar()
    }

    func presentDetailScreen(_ postIndexPath: IndexPath) {
        let presentController = PostsViewController(postIndexPath)
        presentController.modalPresentationStyle = .pageSheet
        present(presentController, animated: true)
    }
}

extension ProfileViewController {
    private func setNavigationBar() {
        let profileNameLabel = UILabel()
        profileNameLabel.text = "kerikg"
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
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
