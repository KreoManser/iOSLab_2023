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
    var animator: UIViewPropertyAnimator?
    var finishTimer: Timer?
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        gameDataManager = GameDataManager.shared
        setupView()
        setupNav()
       checkFinish()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let gameView = gameView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(spaceShipTapped))
            gameView.spaceShip.addGestureRecognizer(tapGesture)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            gameView.spaceShip.addGestureRecognizer(panGesture)
        }
    }

    private func setupView() {
        gameView = GameView(frame: view.bounds)
        gameDataManager?.gameView = gameView
        gameView?.delegate = gameDataManager as? any CollisionDelegate
        view = gameView
    }
    private func setupNav() {
        navigationItem.hidesBackButton = true
    }

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let spaceShip = recognizer.view else { return }

        let translation = recognizer.translation(in: spaceShip.superview)
        spaceShip.center = CGPoint(x: spaceShip.center.x + translation.x, y: spaceShip.center.y + translation.y)
        recognizer.setTranslation(.zero, in: spaceShip.superview)
        gameView?.spaceshipCenterx?.constant = spaceShip.center.x - spaceShip.superview!.center.x
    }

    @objc private func spaceShipTapped() {
        gameView?.setupSpaceshipWeapon()
    }

    private func endGame() {
        let alertController = UIAlertController(
            title: "Game Over",
            message: "Do you want to continue?",
            preferredStyle: .alert
        )

        let continueAction = UIAlertAction(
            title: "Continue",
            style: .default,
            handler: { _ in
                self.gameView?.liveCount.text = "Players'sLives: 5"
                self.gameView?.scoreLabel.text = "Score: 0"
            }
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                let startView = StartViewController()
                self.navigationController?.pushViewController(startView, animated: true)
            }
        )

        alertController.addAction(continueAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc private func finish() {
        let aliens = gameView?.aliens
        let life = gameView?.liveCount.text
        if aliens?.isEmpty == true  || life == "Players'sLives: 0" {
            endGame()
            finishTimer?.invalidate()
            gameView?.collisionTimer?.invalidate()
            gameView?.alienTimer?.invalidate()
            gameView?.alienCollision?.invalidate()

        }
    }
    private func checkFinish() {
        finishTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                           selector: #selector(finish), userInfo: nil, repeats: true)
    }
}
