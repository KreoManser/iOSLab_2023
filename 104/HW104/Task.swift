//
//  User.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 21.01.2024.
//

import UIKit

struct Task: Hashable, Identifiable {
    let id: UUID = UUID()
    var title: String
    var isTaskDone: Bool
    var priority: TaskPriority
    var dateOfCreating: Date
    var dateOfExpiration: Date
}

enum TaskPriority: Comparable {
    case high
    case middle
    case low
    case none
    
    static func < (lhs: TaskPriority, rhs: TaskPriority) -> Bool {
        switch (lhs, rhs) {
        case (.high, _):
            return false
        case (_, .high):
            return true
        case (.middle, _):
            return false
        case (_, .middle):
            return true
        case (.low, _):
            return false
        case (_, .low):
            return true
        default:
            return false
        }
    }
}
