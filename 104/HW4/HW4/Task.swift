//
//  Task.swift
//  HW4
//
//  Created by Kseniya Skvortsova on 05.10.2023.
//

import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    let name: String
    let subtitle: String
    let startingDate: String
    let endingDate: String
    let type: String
}
