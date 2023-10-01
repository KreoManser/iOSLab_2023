//
//  Task.swift
//  Homework4
//
//  Created by kerik on 01.10.2023.
//

import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    var title: String
    var description: String
    var priority: Priority
    var creationDate: Date
    var IsCompletedImageName: String
    //var status: Status
    var isCompleted: Bool
    
    init(title: String, description: String, priority: Priority) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.priority = priority
        self.creationDate = Date()
        //self.status = .unfinished
        self.isCompleted = false
        IsCompletedImageName = "icon1"
    }
}

//enum Status: String {
//    case finished
//    case unfinished
//}

enum Priority: Int {
    case low = 1
    case medium = 2
    case high = 3
}
