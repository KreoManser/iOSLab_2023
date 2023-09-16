//
//  AdditionalTasks.swift
//  Homework_2
//
//  Created by Камил Хайрутдинов on 15.09.2023.
//

import Foundation
import UIKit

func firstEvenNumber(numbers: [Int]) -> Int? {
    return numbers.first { $0 % 2 == 0 }
}

func firstStringStartingWith(strings: [String], firstCharacter: Character) -> String? {
    return strings.first { $0.first == firstCharacter }
}
