//
//  Task.swift
//  homework_4
//
//  Created by Кирилл Щёлоков on 02.10.2023.
//

import Foundation

struct Task: Hashable, Identifiable{
    let id: UUID
    var title: String
    var description: String
    var creationDate: Date
    var completionDate: Date?
    var priority: Int?
}
