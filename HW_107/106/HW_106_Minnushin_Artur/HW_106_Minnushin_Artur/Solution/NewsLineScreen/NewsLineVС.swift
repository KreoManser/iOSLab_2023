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
    var dataManger = DataManager.sigelton
    var delegate: UpdateData?
    override func viewDidLoad() {
        super.viewDidLoad()
        newsLineView.newsLineVC = self
        newsLineView.setupDataSourse(
            collectiondataSource: newsLineCollDataSoutce,
            tableDataSource: newsLineTableDataSoutce)
    }
    override func loadView() {
        view = newsLineView
    }
    func deletePost(postId: Int, postUserId: Int) {
        dataManger.deletePostsById(postId: postId, postUserid: postUserId)
        newsLineView.reloadData()
        delegate?.updateData()
    }
}
