//
//  Task.swift
//  104
//
//  Created by Dmitry on 29.09.2023.
//

import UIKit

struct Task: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var description: String
}

