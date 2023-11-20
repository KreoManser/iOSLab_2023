//
//  GameViewController.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 20.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    var gameView = GameView(frame: .zero)
    var player: Player = Player()
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.setupPlayer(player: player)
    }
    override func loadView() {
        view = gameView
    }
}
