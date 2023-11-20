import UIKit

class GameController: UIViewController {
    private lazy var gameView = GameView(frame: .zero)

    override func loadView() {
        view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameView.gameViewController = self
    }
}

extension GameController {
    func configureEnemy(enemyImageView: UIImageView) {
        let enemy = GameManager.shared.getRandEnemy()
        enemyImageView.image = UIImage(named: enemy) ?? UIImage()
    }

    func increaseScore(scoreLabel: UILabel) { scoreLabel.text = "\(GameManager.shared.increaseScore())" }

    func checkGame() {
        if GameManager.shared.getCurHealth() <= 0 {
            gameView.showMenu()
            GameManager.shared.restartGame()
        }
    }
}
