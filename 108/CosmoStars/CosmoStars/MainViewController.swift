//
//  MainViewController.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

class MainViewController: UIViewController {
    private var mainView = MainView(frame: .zero)

    override func loadView() {
        super.loadView()
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        mainView.moveAlienShipsToNewPositions()
    }
}

