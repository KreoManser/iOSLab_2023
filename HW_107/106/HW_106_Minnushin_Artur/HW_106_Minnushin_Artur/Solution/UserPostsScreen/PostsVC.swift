//
//  PublicationViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 02.11.2023.
//

import UIKit

class PostsViewController: UIViewController {
    var indexPath: IndexPath?
    let publicationView = PostsView(frame: .zero)
    let publicatiomDataSource = PostsDataSource()
    var dataManger = DataManager.sigelton
    var coreDataManager = CoreDataManager.shared
    var deleagte: UpdateData?
    override func viewDidLoad() {
        super.viewDidLoad()
        publicationView.setupDataSource(dataSource: publicatiomDataSource)
        publicationView.publicationViewController = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        publicationView.scrollToSellectedCell(indexPath: self.indexPath!)
    }
    override func loadView() {
        view = publicationView
    }
    init (indexPath: IndexPath) {
        super.init(nibName: "", bundle: nil)
        self.indexPath = indexPath
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func dismisPublicationVC() {
        dismiss(animated: true, completion: nil)
    }
    func deletePost(postId: Int, userId: Int) {
        coreDataManager.deletePostById(userId: userId, postId: postId)
        publicationView.reloadData()
        deleagte?.updateData()
    }
    func tapLikeButton(postId: Int, userId: Int) {
        coreDataManager.updateLikedPost(userId: userId, postId: postId)
    }
}
