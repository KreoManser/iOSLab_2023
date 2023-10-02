//
//  LevelOfPrority.swift
//  NotesApp
//
//  Created by Mac on 2023-10-02.
//

import Foundation

enum LevelOfPrority: Int, CustomStringConvertible {
    case high = 3
    case middle = 2
    case low = 1
    
    var description: String {
        switch self {
        case .high:
            return "High priority"
        case .middle:
            return "Middle priority"
        case .low:
            return "Low priority"
        }
    }
}
