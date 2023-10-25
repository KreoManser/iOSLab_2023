//
//  ProfileViewController.swift
//  Insta_HW6
//
//  Created by Камил Хайрутдинов on 25.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Variables
    private lazy var profileView = ProfileView(frame: .zero)
    override func loadView() {
        view = profileView
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ad")
    }
}
