//
//  ViewController.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 15.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    private var gameView: GameView?
    var gameDataManager: GameDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        gameDataManager = GameDataManager.shared
        setupView()
        setGesture()

    }

    private func setupView() {
        gameView = GameView(frame: view.bounds)
        view = gameView
    }
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(spaceshipTapped))
        gameView?.spaceshipView.addGestureRecognizer(tapGesture)

    }
    @objc private func spaceshipTapped() {
        print("spaceship tapped.")
        gameDataManager?.shootBullets()
    }

}
