//
//  ViewController.swift
//  SpaceInvaders
//
//  Created by Ruslan Kozlov on 15.11.2023.
//

import UIKit

class ViewController: UIViewController {

    var gameView: GameView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    }

    override func viewDidAppear(_ animated: Bool) {
        gameView?.downwardMovementShip()
    }

    func setupSettings() {
        gameView = GameView(frame: .zero)
        view = gameView
    }
}

