//
//  TaskFilterSortOptions.swift
//  homework_4
//
//  Created by Кирилл Щёлоков on 02.10.2023.
//

import Foundation

enum SortOption {
    case creationDate, completionDate, priority
}

class TaskFilterSortOptions {
    var sortOption: SortOption? 
    
    init(sortOption: SortOption? = nil) {
        self.sortOption = sortOption
    }
}
