//
//  StoryViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryViewController: UIViewController {

    lazy var storyView = StoryView(frame: .zero)
    var currentCat: Cat?
    override func loadView() {
        super.loadView()
        view = storyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyView.setupNavigationBar()
        storyView.controler = self
    }
    func setData(cat: Cat) {
        //guard let newCat = cat else {return}
        currentCat = cat
        storyView.publishers = cat.publishers
    }
}
