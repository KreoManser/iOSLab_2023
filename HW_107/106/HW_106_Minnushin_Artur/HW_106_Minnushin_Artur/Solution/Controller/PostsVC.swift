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
    func deletePost(indexPath: IndexPath) {
        dataManger.asyncDelete(indexPath: indexPath.row)
        publicationView.reloadData()
        deleagte?.updateData()
    }
    func searchPostsByName(name: String) {
        dataManger.asyncSearchByName(postName: name)
    }
    func addLikedPost(indexPath: IndexPath) {
        dataManger.syncSaveLikedPost(indexPath: indexPath.row)
    }
    func deleteLikedPost(indexPath: IndexPath) {
        dataManger.syncDeleteLikePost(indexPath: indexPath.row)
    }
}
