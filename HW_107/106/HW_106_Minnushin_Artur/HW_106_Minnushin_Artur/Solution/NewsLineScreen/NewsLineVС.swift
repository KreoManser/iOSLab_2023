//
//  NewsLineVC.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 01.12.2023.
//

import UIKit
import CoreData

class NewsLineViewController: UIViewController {
    let newsLineView = NewsLineView(frame: .zero)
    let newsLineCollDataSoutce = NewsLineCollectionDataSource()
    let newsLineTableDataSoutce = NewsLineTableDataSource()
    var fetchedResultController: NSFetchedResultsController<Post>!
    let coreDataManager = CoreDataManager.shared
    var delegate: UpdateData?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = coreDataManager.createPreparedFetchedPostResultController()
        newsLineTableDataSoutce.setupFetchedResultController(fetchedResultController: fetchedResultController)
        newsLineView.fetchedResultController = fetchedResultController
        newsLineView.newsLineVC = self
        newsLineView.setupDataSourse(
            collectiondataSource: newsLineCollDataSoutce,
            tableDataSource: newsLineTableDataSoutce)
    }
    override func loadView() {
        view = newsLineView
    }
    func deletePost(postId: Int, postUserId: Int) {
        coreDataManager.deletePostById(userId: postUserId, postId: postId)
        newsLineView.reloadData()
        delegate?.updateData()
    }
    func tapLikeButton(postId: Int, userId: Int) {
        coreDataManager.tapLikeButtonFunc(userId: userId, postId: postId)
    }
    @objc
    func refresh() {
        newsLineView.reloadData()
    }
}
