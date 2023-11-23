//
//  Lvl.swift
//  108_Tukaev
//
//  Created by surexnx on 24.11.2023.
//

import Foundation

struct Lvl {
    var evilHealth: Int
    var evilSpead: Double
    var evilBulletGenerate: Double
    var evilGenerate: Double

    init(_ evilHealth: Int, _ evilSpead: Double, _ evilBulletGenerate: Double, _ evilGenerate: Double) {
        self.evilHealth = evilHealth
        self.evilSpead = evilSpead
        self.evilBulletGenerate = evilBulletGenerate
        self.evilGenerate = evilGenerate
    }
}
