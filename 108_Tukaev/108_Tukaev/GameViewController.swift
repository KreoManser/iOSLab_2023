//
//  ViewController.swift
//  108_Tukaev
//
//  Created by surexnx on 19.11.2023.
//

import UIKit

class GameViewController: UIViewController {

    lazy var gameView: GameView = {
        return GameView()
    }()

    init(lvl: Int) {
        super.init(nibName: nil, bundle: nil)

        gameView.setupLvl(lvl: lvl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        }

    override func loadView() {
        view = gameView
        gameView.controller = self
    }
}
