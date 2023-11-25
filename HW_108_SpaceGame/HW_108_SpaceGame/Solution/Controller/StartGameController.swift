//
//  ViewController.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 19.11.2023.
//

import UIKit

protocol SecondeViewController: AnyObject {
    func getResultText(text: String)
}

class StartGameViewController: UIViewController {
    let gameView = StartGameView(frame: .zero)
    let player = Player.sigelton
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.gameController = self
        gameView.player = player
        gameView.setupCreditsTotalCount(credits: player.getCredits())
    }
    override func loadView() {
        view = gameView
    }
    func startGameFunc () {
        let gameVC = GameViewController()
        gameVC.delegate = self
        gameVC.modalPresentationStyle = .overFullScreen
        present(gameVC, animated: true)
    }
    func shopGameFunc() {
        let shopVC = ShopViewController()
        shopVC.modalPresentationStyle = .overFullScreen
        present(shopVC, animated: true)
    }
}
extension StartGameViewController: SecondeViewController {
    func getResultText(text: String) {
        gameView.setupResultLabel(text: text)
    }
}
