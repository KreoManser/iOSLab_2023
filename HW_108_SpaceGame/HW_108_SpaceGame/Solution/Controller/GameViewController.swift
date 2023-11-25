//
//  GameViewController.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 20.11.2023.
//

import UIKit

class GameViewController: UIViewController {
    var gameView = GameView(frame: .zero)
    var player = Player.sigelton
    weak var delegate: SecondeViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.setupPlayer(player: player)
        gameView.gameVC = self
    }
    override func loadView() {
        view = gameView
    }
    func dismisVC(text: String) {
        self.delegate?.getResultText(text: text)
        dismiss(animated: true, completion: nil)
    }
}
