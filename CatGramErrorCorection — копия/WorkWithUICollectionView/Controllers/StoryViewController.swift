//
//  StoryViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 04.11.2023.
//

import UIKit

class StoryViewController: UIViewController {

    private lazy var storyView = StoryView(frame: .zero)
    override func loadView() {
        super.loadView()
        view = storyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyView.setupNavigationBar()
        storyView.controler = self
    }
}
