//
//  ViewController.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 19.11.2023.
//

import UIKit

class StartGameViewController: UIViewController {
    let gameView = StartGameView(frame: .zero)
    let gameManager = GameManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.gameController = self
        gameView.gameManager = gameManager
        gameView.setupCreditsTotalCount(credits: gameManager.totalScore)
    }
    override func loadView() {
        view = gameView
    }
    func startGameFunc () {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .overFullScreen
        present(gameVC, animated: true)
    }
}
