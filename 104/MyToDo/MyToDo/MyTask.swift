//
//  MyTask.swift
//  MyToDo
//
//  Created by Rustem on 02.10.2023.
//
import Foundation

struct MyTask: Identifiable, Hashable {
    var id: UUID
    var title: String = ""
    var description: String = ""
    var creationDate: Date
    var priority: Int
    var isCompleted: Bool
    
    init(title: String, description: String, priority: Int) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.creationDate = Date()
        self.priority = priority
        self.isCompleted = false
    }
    
    public func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
        }
        
        public static func == (lhs: MyTask, rhs: MyTask) -> Bool {
            return lhs.id == rhs.id
        }
}
