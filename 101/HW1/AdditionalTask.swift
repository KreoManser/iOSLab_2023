//
//  AdditionalTask.swift
//  HW1
//
//  Created by Alina on 14.09.2023.
//

import Foundation

func filteredWords (array: [String]) -> [String] {
    array.filter{ $0.count > 5 }
}

func filteredNumbers (array: [Int]) -> [Int] {
    array.filter{ $0 % 2 == 0 }
}
