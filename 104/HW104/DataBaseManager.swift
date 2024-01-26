//
//  DataBaseManager.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 23.01.2024.
//

import Foundation
import UIKit

class DataBaseManager {
    
    private var dataSource: [Task] = [
        Task(title: "Первая задача", isTaskDone: false, priority: .middle, dateOfCreating: .now, dateOfExpiration: .now),
        Task(title: "Вторая задача", isTaskDone: false, priority: .middle, dateOfCreating: .now, dateOfExpiration: .now),
        Task(title: "Третья задача", isTaskDone: false, priority: .middle, dateOfCreating: .now, dateOfExpiration: .now),
        Task(title: "Четвертая задачd", isTaskDone: false, priority: .middle, dateOfCreating: .now, dateOfExpiration: .now)
    ]
    
    func getAllTasks() -> [Task] {
        return dataSource
    }
    
    func removeTask(at index: Int) {
        dataSource.remove(at: index)
    }
    
    func update(task: Task) {
        guard let index = dataSource.firstIndex(where: { $0.id == task.id }) else { return }
        dataSource.remove(at: index)
        dataSource.insert(task, at: index)
    }
    
    func insert(task: Task, at index: Int) {
        dataSource.insert(task, at: index)
    }
}
