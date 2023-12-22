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
    var newsLineTableDataSoutce: NewsLineTableDataSource!
    var fetchedResultController: NSFetchedResultsController<Post>!
    let coreDataManager = CoreDataManager.shared
    var delegate: UpdateData?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = coreDataManager.createPreparedFetchedPostResultController()
        newsLineTableDataSoutce = NewsLineTableDataSource(controller: fetchedResultController)
        newsLineView.setupFetchController(controller: fetchedResultController)
        newsLineView.newsLineVC = self
        newsLineView.setupDataSourse(
            collectiondataSource: newsLineCollDataSoutce,
            tableDataSource: newsLineTableDataSoutce)
    }
    override func viewDidAppear(_ animated: Bool) {
        newsLineView.updateTableWithCachedData()
    }
    override func loadView() {
        view = newsLineView
    }
    func updateController() {
        newsLineView.updateTableWithCachedData()
    }
    func deletePost(postId: Int, postUserId: Int) {
        coreDataManager.deletePostById(userId: postUserId, postId: postId)
        newsLineView.reloadData()
        delegate?.updateData()
    }
    func tapLikeButton(postId: Int, userId: Int) {
        coreDataManager.updateLikedPost(userId: userId, postId: postId)
    }
}
