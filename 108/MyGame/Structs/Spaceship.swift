//
//  Spaceship.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 18.11.2023.
//

import Foundation

class Spaceship {
    var weaponPower:  Int
    var liveCount: Int

    init( weaponPower: Int, liveCount: Int ) {
        self.weaponPower = weaponPower
        self.liveCount = liveCount
    }

    func isAlive() -> Bool {
        if liveCount == 0 {
            return false
        }
        return true
    }


}
