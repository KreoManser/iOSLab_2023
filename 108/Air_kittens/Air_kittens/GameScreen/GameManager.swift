import Foundation
import UIKit

protocol GameManagerProtocol {
    func getRandXPosition(screenBounds: CGRect) -> CGFloat
    func getRandEnemy() -> String
    func getCurScore() -> Int
    func getCurHealth() -> Int
    func increaseScore() -> Int
    func decreaseHealth()
    func restartGame()
}

class GameManager: GameManagerProtocol {
    static var shared = GameManager()
    private var enemyArray: [String] = []
    private var playersScore = 0
    private var playersHealth = 3

    init() {
        enemyArray = ["Enemy1", "Enemy2", "Enemy3"]
    }
    func getRandXPosition(screenBounds: CGRect) -> CGFloat { CGFloat.random(in: 40..<screenBounds.width - 50) }

    func getRandEnemy() -> String {
        let index = Int.random(in: 0..<enemyArray.count)
        return enemyArray[index]
    }

    func increaseScore() -> Int {
        playersScore += 1
        return getCurScore()
    }

    func decreaseHealth() { playersHealth -= 1 }

    func restartGame() {
        playersScore = 0
        playersHealth = 3
    }

    func getCurScore() -> Int { playersScore }

    func getCurHealth() -> Int { playersHealth }
}
