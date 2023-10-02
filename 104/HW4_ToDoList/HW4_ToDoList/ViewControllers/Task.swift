//
//  Task.swift
//  HW4_ToDoList
//
//  Created by Артур Миннушин on 02.10.2023.
//

import UIKit

struct Task: Hashable, Identifiable {
    let id : UUID
    let nameTask: String
    let descriptionTask: String
}
