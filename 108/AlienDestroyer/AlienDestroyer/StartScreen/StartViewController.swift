//
//  StartViewController.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import UIKit

class StartViewController: UIViewController {

    private var startView: StartView?
    private var gameView: GameView?
    private var gameDataManager: GameDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        gameDataManager = GameDataManager()
        setUpStartView()
    }

    private func setUpStartView() {
        startView = StartView(frame: view.bounds, score: gameDataManager?.getScore() ?? "0")
        startView?.startButtonTapped = { [weak self] diffIndex in
            self?.setUpGameView(diff: self?.gameDataManager?.getDiff(diffIndex: diffIndex) ?? (3, 2))
        }
        view = startView
    }

    private func setUpGameView(diff: (spawnSpeed: Double, enemyAttackSpeed: Double)) {
        gameView = GameView(frame: view.bounds, diff: diff)
        gameView?.homeButtonTapped = { [weak self] in
            self?.setUpStartView()
        }
        gameView?.delegate = gameDataManager
        view = gameView
    }
}
