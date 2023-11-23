//
//  MainViewController.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

class MainViewController: UIViewController {
    private var mainView = MainView(.zero, 1, 1)

    override func loadView() {
        super.loadView()
        view = mainView
    }
}

