//
//  NewsLineVC.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 01.12.2023.
//

import UIKit

class NewsLineViewController: UIViewController {
    let newsLineView = NewsLineView(frame: .zero)
    let newsLineCollDataSoutce = NewsLineCollectionDataSource()
    let newsLineTableDataSoutce = NewsLineTableDataSource()
    let coreDataManager = CoreDataManager.shared
    var delegate: UpdateData?
    var myTimer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsLineView.newsLineVC = self
        newsLineView.setupDataSourse(
            collectiondataSource: newsLineCollDataSoutce,
            tableDataSource: newsLineTableDataSoutce)
        self.myTimer = Timer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(refresh),
                             userInfo: nil, repeats: true)
                RunLoop.main.add(self.myTimer, forMode: .default)
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
