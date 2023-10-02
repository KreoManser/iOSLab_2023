//
//  Note.swift
//  NotesApp
//
//  Created by Mac on 2023-10-01.
//

import Foundation

struct Note: Hashable, Identifiable {
    let id: UUID = UUID()
    var title: String
    var describtion: String
    var iconName: String
    let startDate: Date
    let endDate: Date
    var levelOfPriority: LevelOfPrority
    var isDone: Bool = false

    init(title: String, describtion: String, iconName: String, endDate: Date, levelOfPriority: LevelOfPrority, isDone: Bool) {
        self.title = title
        self.describtion = describtion
        self.iconName = iconName
        self.startDate = Date()
        self.endDate = endDate
        self.levelOfPriority = levelOfPriority
        self.isDone = isDone
    }
}
