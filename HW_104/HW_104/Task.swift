//
//  Task.swift
//  HW_104
//
//  Created by Азат Зиганшин on 02.10.2023.
//

import Foundation
import UIKit

struct Task: Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
}
