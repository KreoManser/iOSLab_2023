//
//  TaskList.swift
//  ToDoApp
//
//  Created by Faki Doosuur Doris on 30.09.2023.
//

import Foundation

enum Priority: Int, Comparable {
    static func < (lhs: Priority, rhs: Priority) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    case low = 0
    case medium = 1
    case high = 2
}

struct TaskToDo: Hashable, Identifiable {
    var id: UUID
    var tasks: String = ""
    var description: String = ""
    var isCompleted: Bool
    var creationDate: Date?
    var completionDate: Date?
    var priority: Priority
    
    init(id: UUID, tasks: String, description: String, isCompleted: Bool, creationDate: Date, completionDate: Date, priority: Priority) {
        self.id = id
        self.tasks = tasks
        self.description = description
        self.isCompleted = isCompleted
        self.creationDate = creationDate
        self.completionDate = completionDate
        self.priority = priority
    }
}
extension Date {
    init(month: Int, day: Int, year: Int) {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.year = year
        dateComponents.timeZone = .current
        dateComponents.calendar = .current
        self = Calendar.current.date(from: dateComponents) ?? Date()
    }
}
