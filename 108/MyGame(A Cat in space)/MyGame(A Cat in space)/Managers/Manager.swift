//
//  Manager.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import UIKit

class Manager {
    static var shared = Manager()
    private let size = CGRect(x: 0, y: 0, width: 70, height: 70)
    var dictionaryAliens: [String: [Alien]] = [:]
    let easyAliens: [Alien] = []
    let midleAliens: [Alien] = []
    let difficultAliens: [Alien] = []
    private var positionsAliens: [CGPoint] = []
    private let levels: [String] = ["Easy", "Midle", "Hard"]

    func getLevels() -> [String] {
        return levels
    }
    func getLocationForEasyAlien() {
        var numberOfAliens: Int = 5
        var alienWidth: CGFloat = 50
        var spaceBetweenAliens: CGFloat = 20
        let totalWidth = CGFloat(numberOfAliens) * (alienWidth + spaceBetweenAliens) - spaceBetweenAliens
        let startX = ((UIScreen.main.bounds.width - totalWidth) / 2) + 20
        for i in 0..<numberOfAliens {
            let xPosition = startX + CGFloat(i) * (alienWidth + spaceBetweenAliens)
            let positionAlien = CGPoint(x: xPosition, y: 100 + CGFloat(i) * 20)
            positionsAliens.append(positionAlien)
        }
    }
    private init() {
        getLocationForEasyAlien()
        let easyAliens = [
            Alien(position: positionsAliens[0], health: 10, damage: 10, image: UIImage(named: "Alien_1"),size: size),
            Alien(position: positionsAliens[1], health: 10, damage: 10, image: UIImage(named: "Alien_1"), size: size),
            Alien(position: positionsAliens[2], health: 10, damage: 10, image: UIImage(named: "Alien_1"), size: size),
            Alien(position: positionsAliens[3], health: 10, damage: 10, image: UIImage(named: "Alien_1"), size: size),
            Alien(position: positionsAliens[4], health: 10, damage: 10, image: UIImage(named: "Alien_1"), size: size),
        ]
        let midleAliens = [
            Alien(position: positionsAliens[0], health: 20, damage: 40, image: UIImage(named: "Alien_2"), size: size),
            Alien(position: positionsAliens[1], health: 20, damage: 40, image: UIImage(named: "Alien_2"), size: size),
            Alien(position: positionsAliens[2], health: 20, damage: 40, image: UIImage(named: "Alien_2"), size: size),
            Alien(position: positionsAliens[3], health: 20, damage: 40, image: UIImage(named: "Alien_2"), size: size),
            Alien(position: positionsAliens[4], health: 20, damage: 40, image: UIImage(named: "Alien_2"), size: size),
        ]
        let difficultAliens = [
            Alien(position: positionsAliens[0], health: 30, damage: 100, image: UIImage(named: "BossAlien"), size: size),
            Alien(position: positionsAliens[1], health: 30, damage: 100, image: UIImage(named: "BossAlien"), size: size),
            Alien(position: positionsAliens[2], health: 30, damage: 100, image: UIImage(named: "BossAlien"), size: size),
            Alien(position: positionsAliens[3], health: 30, damage: 100, image: UIImage(named: "BossAlien"), size: size),
            Alien(position: positionsAliens[4], health: 30, damage: 100, image: UIImage(named: "BossAlien"), size: size),
        ]
        dictionaryAliens["Easy"] = easyAliens
        dictionaryAliens["Midle"] = midleAliens
        dictionaryAliens["Hard"] = difficultAliens
    }

    func choiceDifficulties(level: String) -> [Alien] {
        return dictionaryAliens[level] ?? []
    }

}
