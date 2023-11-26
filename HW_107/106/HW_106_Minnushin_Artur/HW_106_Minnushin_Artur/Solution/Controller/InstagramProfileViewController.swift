//
//  ViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.10.2023.
//

import UIKit

protocol GetData: AnyObject {
    func getData() -> User
}
class InstagramProfileViewController: UIViewController {
    
    let dataSource = ProfileCollectionDataSource()
    let profileView = InstargramProfileView(frame: .zero)
    var user: User
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.setupPosts(posts: user.posts)
        profileView.configureCollection(dataSource: dataSource)
        profileView.profileViewController = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.reloadData()
    }
    override func loadView() {
        view = profileView
    }
    init(user: User) {
        self.user = user
        profileView.configureUserProfile(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func publicationPresintation(indexPath: IndexPath) {
        let publicationVC = PublicationViewController(indexPath: indexPath)
        publicationVC.delegate = self
        publicationVC.modalPresentationStyle = .overFullScreen
        present(publicationVC, animated: true)
    }
}

extension InstagramProfileViewController: GetData {
    func getData() -> User {
        return user
    }
}
