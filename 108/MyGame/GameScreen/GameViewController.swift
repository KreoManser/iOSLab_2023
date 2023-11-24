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
    var firingTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        gameDataManager = GameDataManager.shared
        setupView()
        setupNav()
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
     //   view.backgroundColor = .brown
    }
    private func setupNav() {
        navigationItem.hidesBackButton = true
    }

    @objc private func fireBullet() {
        let initialX = gameView!.spaceShip.frame.origin.x + 20
        let initialY = gameView!.spaceShip.frame.origin.y

        gameView!.playerWeapon.layer.frame = CGRect(x: initialX, y: initialY, width: 20, height: 20)
        gameView?.addSubview(gameView!.playerWeapon)
        // gameView?.playerWeapon.translatesAutoresizingMaskIntoConstraints = false
        gameView!.playerWeapon.isHidden = false
        gameView!.playerWeapon.image = UIImage(named: "bullet2")

        UIView.animate(withDuration: 4.0) {
            self.gameView!.playerWeapon.frame.origin.y -= 700

            if let aliens = self.gameView?.aliens {
                for alien in aliens {

                    let bulletFrame = self.gameView!.playerWeapon.bounds
                    let alienFrame = alien.bounds
                    print("Collision Check - SpaceShip Frame: \(bulletFrame)")
                    print("Collision Check - AlienBullet Frame: \(alienFrame)")
                    if bulletFrame.intersects(alienFrame) {
                        // Collision detected
                        print("Collision detected with an alien")
                        // Handle the collision (e.g., remove the alien)
                        self.gameDataManager?.handleSpacecollision(bullet: self.gameView!.playerWeapon, target: alien)
                    //    self.gameView?.playerWeapon.removeFromSuperview()
                       // alien.removeFromSuperview()
                        //  self.gameView?.handleExplosion(at: alien.center, target: alien)
                    } else {
                        print("no detection")
                    }
                }
            }
        }
        // Remove the bullet after the animation is complete
        //  self.gameView!.playerWeapon.removeFromSuperview()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.gameView!.playerWeapon.removeFromSuperview()

        }
    }

    // function to drag spaceship to dodge bullets from spaceships
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        guard let spaceShip = gameView?.spaceShip else { return }
        let translation = recognizer.translation(in: view)
        let newX = max(0, min(view.frame.width - spaceShip.frame.width, spaceShip.frame.origin.x + translation.x))
        spaceShip.frame.origin.x = newX
        recognizer.setTranslation(.zero, in: view)
    }

    @objc private func spaceShipTapped() {
            fireBullet()
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
                    // Handle game cancellation or exit the game
                }
            )

            alertController.addAction(continueAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }

//    func isCollision(view1: UIImageView, view2: UIImageView) -> Bool {
//            let center1 = CGPoint(x: view1.frame.midX, y: view1.frame.midY)
//            let center2 = CGPoint(x: view2.frame.midX, y: view2.frame.midY)
//
//            let distance = sqrt(pow(center1.x - center2.x, 2) + pow(center1.y - center2.y, 2))
//            let collisionThreshold = (view1.frame.width + view2.frame.width) / 4 // Adjust as needed
//
//            return distance < collisionThreshold
//        }
}
