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
    var currentEnemuHP: Int = 0

    private var enemyImageNameFrame: [String: Int] = [:]

    init() {
        enemyImageNameFrame["Alien1"] = CGRect(x: 0, y: 0, width: 50, height: 50)
        enemyImageNameFrame["Alien2"] = CGRect(x: 0, y: 0, width: 50, height: 100)
        enemyImageNameFrame["Alien3"] = CGRect(x: 0, y: 0, width: 60, height: 40)
    }

    func getCurrentXCoordinate(startX: CGFloat, endX: CGFloat, value: Float) -> CGFloat {
        return startX + (endX - startX) * CGFloat(value)
    }

    func getRandomXcoordinate(screenFrame: CGRect) -> CGFloat {
        CGFloat.random(in: 50..<screenFrame.width - 100)
    }

    func getRandomEnemy() -> (imageName: String, frame: CGRect) {
        let keys = Array(enemyImageNameFrame.keys)
        let randomKey = keys[Int.random(in: 0..<keys.count)]
        let enemyFrame = enemyImageNameFrame[randomKey]

        return (randomKey, enemyFrame ?? CGRect())

    }

}
