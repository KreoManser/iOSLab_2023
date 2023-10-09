//
//  Task.swift
//  HW4
//
//  Created by Alina on 09.10.2023.
//

import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    var title: String
    var description: String
}
