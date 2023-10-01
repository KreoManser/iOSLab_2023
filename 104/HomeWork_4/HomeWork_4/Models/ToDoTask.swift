//
//  ToDoTask.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 29.09.2023.
//

import Foundation

enum TaskPriority: Int {
    case low = 1
    case medium = 2
    case high = 3
}

struct ToDoTask: Hashable, Identifiable {
    let id: UUID
    var name: String = ""
    var description: String = ""
    var creationDate: Date
    var priority: TaskPriority
    var isCompleted: Bool
    var endDate: Date?
    
    init(name: String, description: String) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.creationDate = Date()
        self.priority = .low
        self.isCompleted = false
    }
    
    init() {
        self.creationDate = Date()
        self.id = UUID()
        self.priority = .low
        self.isCompleted = false
    }
}
