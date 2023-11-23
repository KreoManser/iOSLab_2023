import UIKit
protocol GameViewDelegate: AnyObject {
    func hitShip()
    func checkAliensKilled()
    func addHP()
}

protocol DataManagerDelegate: AnyObject {
    func gameOver()
}

class GameViewController: UIViewController, GameViewDelegate, DataManagerDelegate {
    let gameView = GameView(frame: UIScreen.main.bounds)
    let dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        dataManager.delegate = self
        view = gameView
        dataManager.checkDifficult()
        gameView.createAliens(
            shipCount: 4,
            alienImage: "enemyship",
            height: 50,
            health: dataManager.aliensHP,
            bulletSpeed: 1.5)
    }
    func hitShip() {
        dataManager.changeHP()
    }
    func checkAliensKilled() {
        if gameView.aliensList.isEmpty {
            if dataManager.currentWave & 1 == 0 && dataManager.currentWave != dataManager.countWave {
                gameView.createAliens(
                    shipCount: 4,
                    alienImage: "enemyship2",
                    height: 50,
                    health: dataManager.aliensHP,
                    bulletSpeed: 1.1)
                gameView.getHP()
                gameView.getAdditionalBullet()
            }
            if dataManager.currentWave & 1 != 0 {
                gameView.createAliens(
                    shipCount: 4,
                    alienImage: "enemyship",
                    height: 50,
                    health: dataManager.aliensHP,
                    bulletSpeed: 1.5)
                gameView.getHP()
                gameView.getAdditionalBullet()
            }
            if dataManager.currentWave == dataManager.countWave {
                gameView.createAliens(
                    shipCount: 1,
                    alienImage: "boss",
                    height: 250,
                    health: dataManager.bossHP,
                    bulletSpeed: 1.0)
            }
            if dataManager.currentWave == dataManager.countWave + 1 {
                gameWin()
            }
            dataManager.currentWave += 1
        }
    }
    func gameOver() {
        let gameOverView = GameOverView(victory: false)
        view = gameOverView
        gameOverView.setExitButtonActionClosure { [weak self] in
            let menuView = MenuViewController()
            self?.navigationController?.pushViewController(menuView, animated: true)
        }
    }
    func gameWin() {
        let gameOverView = GameOverView(victory: true)
        view = gameOverView
        gameOverView.setExitButtonActionClosure { [weak self] in
            let menuView = MenuViewController()
            self?.navigationController?.pushViewController(menuView, animated: true)
        }
    }
    func addHP() {
        dataManager.spaceshipHP += 1
    }
}
