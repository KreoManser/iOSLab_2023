//
//  GameManager.swift
//  MyGame
//
//  Created by Камил Хайрутдинов on 18.11.2023.
//

import Foundation

class GameManager {

    var playerScore: Int = 0
    var enemyCount: Int = 0
    var currentEnemyHP: Int = 0
    var isLost: Bool { return playerScore < enemyCount}

    var enemyIsDead: Bool { return currentEnemyHP == 0}

    private var enemyDictionary: [String: Int] = [:]

    init() {
        enemyDictionary["Alien1"] = 2
        enemyDictionary["Alien2"] = 2
        enemyDictionary["Alien3"] = 1
    }

    func getCurrentXCoordinate(startX: CGFloat, endX: CGFloat, value: Float) -> CGFloat {
        return startX + (endX - startX) * CGFloat(value)
    }

    func getRandomXcoordinate(screenFrame: CGRect) -> CGFloat {
        CGFloat.random(in: 50..<screenFrame.width - 100)
    }

    func getRandomEnemy() -> (imageName: String, hp: Int) {
        let keys = Array(enemyDictionary.keys)
        let randomKey = keys[Int.random(in: 0..<keys.count)]
        let enemyhp = enemyDictionary[randomKey]
        currentEnemyHP = enemyhp ?? 1
        return (randomKey, enemyhp ?? 1)

    }

    func addScore() {
        playerScore += 1
    }

    func resetGame() {
        playerScore = 0
        enemyCount = 0
        currentEnemyHP = 0
    }

}
