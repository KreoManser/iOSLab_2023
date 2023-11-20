import UIKit
protocol GameViewDelegate: AnyObject {
    func hitShip()
}

protocol DataManagerDelegate: AnyObject {
    func gameOver()
}

class GameViewController: UIViewController, GameViewDelegate, DataManagerDelegate {
    let gameView = GameView(frame: UIScreen.main.bounds)
    let dataManager = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        dataManager.delegate = self
        view = gameView
    }

    func hitShip() {
        dataManager.changeHP()
    }

    func gameOver() {
        print("игра закончена")
    }
}
