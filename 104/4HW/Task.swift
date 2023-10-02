//
//  Task.swift
//  4HW
//
//  Created by Ruslan on 01.10.2023.
//

import Foundation
import UIKit

struct Task: Hashable, Identifiable {
    let id: UUID
    var title: String
    var description: String
    var status: String
    var dateOfCreation: Date
    var completionDate: Date
}
