//
//  ViewController.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    var profileViewDataSource = ProfileViewDataSource.shared

    override func loadView() {
        view = profileView
        profileView.setupDataSourse(profileViewDataSource)
        profileView.controller = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.photoCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "remy_fluffy"
        self.navigationItem.backButtonTitle = ""

    }
}

