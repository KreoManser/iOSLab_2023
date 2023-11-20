//
//  GameViewDelegate.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 20.11.2023.
//

import Foundation
import UIKit

protocol GameViewDelegate: AnyObject {
    func minusHealth(for view: EntityProtocol, from weapon: WeaponProtocol) -> Int
    func increaseScore(score: String) -> String
    func setBestScore(score: String)
    func getScore() -> String
}
