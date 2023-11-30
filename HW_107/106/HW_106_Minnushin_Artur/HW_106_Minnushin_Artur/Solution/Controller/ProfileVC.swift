//
//  ViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.10.2023.
//

import UIKit

protocol UpdateData: AnyObject {
    func updateData()
}
class ProfileViewController: UIViewController {
    let dataSource = ProfileCollectionDataSource()
    let profileView = ProfileView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        profileView.configureCollection(dataSource: dataSource)
        profileView.profileViewController = self
    }
    override func loadView() {
        view = profileView
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        profileView.configureUserProfile()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func postsViewControllerPresnt(indexPath: IndexPath) {
        let publicationVC = PostsViewController(indexPath: indexPath)
        publicationVC.modalPresentationStyle = .overFullScreen
        publicationVC.deleagte = self
        present(publicationVC, animated: true)
    }
    func settingsViewControllerPresent() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .overFullScreen
        present(settingsVC, animated: true)
    }
}

extension ProfileViewController: UpdateData {
    func updateData() {
        profileView.reloadData()
    }
}
