//
//  ToDoTask.swift
//  HomeWork_4
//
//  Created by Камил Хайрутдинов on 29.09.2023.
//

import Foundation

enum TaskPriority: Int {
    case Low = 1
    case Medium = 2
    case High = 3
}

class DoToTask {
    var name: String = ""
    var description: String = ""
    var creationTime: Date
    var priority: TaskPriority = .Low
    var isCompleted: Bool = false
    var endTime: Date?
    
    init() {
        self.creationTime = Date()
    }
}
